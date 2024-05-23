import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/comment_entity.dart';
import 'package:tiktok_tdd/src/reels/domain/usecases/add_comment.dart';
import 'package:tiktok_tdd/src/reels/domain/usecases/fetch_comments.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  List<CommentEntity> comments = [];
  final AddComment addComment;
  final FetchComments fetchComments;
  CommentsBloc({required this.addComment, required this.fetchComments})
      : super(CommentsInitial()) {
    on<OnAddComment>(_addComment);
    on<OnFetchComments>(_fetchComments);
    on<OnCommentsScreenReturned>(_commentsScreenReturned);
  }

  FutureOr<void> _addComment(
      OnAddComment event, Emitter<CommentsState> emit) async {
    emit(AddCommentLoading());
    final newComment = await addComment.call(AddCommentParams(
        comment: event.comment, videoId: event.videoId, userid: event.userid));

    newComment.fold((l) => emit(CommentsFailure(error: l.message)), (r) {
      comments.add(r);
      emit(CommentsLoaded(comments: comments));
    });
  }

  FutureOr<void> _fetchComments(
      OnFetchComments event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
    final commentsData = await fetchComments.call(event.videoId);
    commentsData.fold((l) => emit(CommentsFailure(error: l.message)), (r) {
      comments = r;
      emit(CommentsLoaded(comments: r));
    });
  }

  Future<void> _commentsScreenReturned(
      OnCommentsScreenReturned event, Emitter<CommentsState> emit) async {
    // Check if reels are already cached
    if (comments.isNotEmpty) {
      emit(CommentsLoaded(comments: comments));
      return;
    }

    // If not cached, fetch reels data
    emit(CommentsLoading());

    final commentsData = await fetchComments.call(event.videoId);
    commentsData.fold((l) => emit(CommentsFailure(error: l.message)), (r) {
      comments = r;
      emit(CommentsLoaded(comments: r));
    });
  }
}
