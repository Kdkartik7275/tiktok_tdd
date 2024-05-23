import 'package:fpdart/fpdart.dart';
import 'package:tiktok_tdd/core/common/errors/failure.dart';
import 'package:tiktok_tdd/core/network/connection_checker.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/reels/data/data_source/reel_remote_data_source.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/comment_entity.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/reel_entity.dart';
import 'package:tiktok_tdd/src/reels/domain/repository/reel_repository.dart';

class ReelRepositoryImpl implements ReelRepository {
  final ReelDataSource reelDataSource;
  final ConnectionChecker connectionChecker;

  ReelRepositoryImpl(
      {required this.reelDataSource, required this.connectionChecker});
  @override
  ResultFuture<CommentEntity> addComment(
      {required String comment,
      required String videoId,
      required String userid}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final newComment = await reelDataSource.addComment(
          comment: comment, videoId: videoId, userid: userid);
      return right(newComment);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<CommentEntity>> fetchComments(
      {required String videoId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final comments = await reelDataSource.fetchComments(videoId: videoId);
      return right(comments);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<ReelEntity>> fetchReels() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final reels = await reelDataSource.fetchReels();
      return right(reels);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<ReelEntity> likeReel(
      {required String userId, required String videoId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final reel =
          await reelDataSource.likeReel(userId: userId, videoId: videoId);
      return right(reel);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  ResultVoid uploadReel(
      {required String userId,
      required String videoPath,
      required String caption,
      required String songName}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      await reelDataSource.uploadReel(
          caption: caption,
          songName: songName,
          userId: userId,
          videoPath: videoPath);
      return right(null);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<UserEntity> uploadedReelUser({required String userId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final user = await reelDataSource.uploadedReelUser(userId: userId);
      return right(user);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }
}
