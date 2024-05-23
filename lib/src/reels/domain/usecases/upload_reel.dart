import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/reels/domain/repository/reel_repository.dart';

class UploadReel implements UseCaseWithParams<void, UploadReelParams> {
  final ReelRepository repository;

  UploadReel({required this.repository});
  @override
  ResultFuture<void> call(UploadReelParams params) async =>
      await repository.uploadReel(
          userId: params.userId,
          videoPath: params.videoPath,
          caption: params.caption,
          songName: params.songName);
}

class UploadReelParams {
  final String userId;
  final String videoPath;
  final String caption;
  final String songName;

  UploadReelParams(
      {required this.userId,
      required this.videoPath,
      required this.caption,
      required this.songName});
}
