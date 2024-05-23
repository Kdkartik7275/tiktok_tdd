import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/reel_entity.dart';
import 'package:tiktok_tdd/src/reels/domain/repository/reel_repository.dart';

class LikeReel implements UseCaseWithParams<ReelEntity, LikeReelParams> {
  final ReelRepository repository;

  LikeReel({required this.repository});
  @override
  ResultFuture<ReelEntity> call(LikeReelParams params) async =>
      await repository.likeReel(userId: params.userId, videoId: params.videoId);
}

class LikeReelParams {
  final String userId;
  final String videoId;

  LikeReelParams({
    required this.userId,
    required this.videoId,
  });
}
