part of 'comments_bloc.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}

final class AddCommentLoading extends CommentsState {}

final class CommentsLoaded extends CommentsState {
  final List<CommentEntity> comments;

  const CommentsLoaded({required this.comments});
}

final class CommentsFailure extends CommentsState {
  final String error;

  const CommentsFailure({required this.error});
}
