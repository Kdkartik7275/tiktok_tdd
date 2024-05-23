import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/comment_entity.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/reel_entity.dart';

abstract interface class ReelRepository {
  ResultVoid uploadReel(
      {required String userId,
      required String videoPath,
      required String caption,
      required String songName});

  ResultFuture<ReelEntity> likeReel(
      {required String userId, required String videoId});

  ResultFuture<CommentEntity> addComment(
      {required String comment,
      required String videoId,
      required String userid});

  ResultFuture<List<CommentEntity>> fetchComments({required String videoId});
  ResultFuture<List<ReelEntity>> fetchReels();

  ResultFuture<UserEntity> uploadedReelUser({required String userId});
}
