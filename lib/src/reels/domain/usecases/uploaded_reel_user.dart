import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/reels/domain/repository/reel_repository.dart';

class UploadedReelUser implements UseCaseWithParams<UserEntity, String> {
  final ReelRepository repository;

  UploadedReelUser({required this.repository});
  @override
  ResultFuture<UserEntity> call(String params) async =>
      await repository.uploadedReelUser(userId: params);
}
