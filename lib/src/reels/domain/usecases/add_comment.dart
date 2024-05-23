import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/comment_entity.dart';
import 'package:tiktok_tdd/src/reels/domain/repository/reel_repository.dart';

class AddComment implements UseCaseWithParams<CommentEntity, AddCommentParams> {
  final ReelRepository repository;

  AddComment({required this.repository});

  @override
  ResultFuture<CommentEntity> call(AddCommentParams params) async =>
      await repository.addComment(
          comment: params.comment,
          videoId: params.videoId,
          userid: params.userid);
}

class AddCommentParams {
  final String comment;
  final String videoId;
  final String userid;

  AddCommentParams(
      {required this.comment, required this.videoId, required this.userid});
}
