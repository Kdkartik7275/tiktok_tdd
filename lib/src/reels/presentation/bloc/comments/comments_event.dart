part of 'comments_bloc.dart';

sealed class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

final class OnAddComment extends CommentsEvent {
  final String comment;
  final String videoId;
  final String userid;

  const OnAddComment(
      {required this.comment, required this.videoId, required this.userid});
}

final class OnFetchComments extends CommentsEvent {
  final String videoId;

  const OnFetchComments({required this.videoId});
}

final class OnCommentsScreenReturned extends CommentsEvent {
  final String videoId;

  const OnCommentsScreenReturned({required this.videoId});
}
