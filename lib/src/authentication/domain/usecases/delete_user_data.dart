import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class DeleteUserData implements UseCaseWithParams<void, String> {
  final AuthRepository repository;

  DeleteUserData({required this.repository});
  @override
  ResultFuture<void> call(String params) async =>
      await repository.deleteUserData(userId: params);
}
