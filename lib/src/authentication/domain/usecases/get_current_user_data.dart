import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class GetCurrentUserData implements UseCaseWithoutParams<UserEntity> {
  final AuthRepository repository;

  GetCurrentUserData({required this.repository});
  @override
  ResultFuture<UserEntity> call() async =>
      await repository.getCurrentUserData();
}
