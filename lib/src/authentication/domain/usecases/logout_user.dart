import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class LogoutUser implements UseCaseWithoutParams<void> {
  final AuthRepository repository;

  LogoutUser({required this.repository});

  @override
  ResultFuture<void> call() async => await repository.logoutUser();
}
