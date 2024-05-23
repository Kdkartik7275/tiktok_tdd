import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/profile/domain/repository/user_repository.dart';

class GetUserData implements UseCaseWithParams<UserEntity, String> {
  final UserRepository repository;

  GetUserData({required this.repository});
  @override
  ResultFuture<UserEntity> call(String params) async =>
      await repository.getUserData(userId: params);
}
