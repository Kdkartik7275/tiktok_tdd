import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class ReAuthenticateWithEmail
    implements UseCaseWithParams<void, ReAuthenticateWithEmailParams> {
  final AuthRepository repository;

  ReAuthenticateWithEmail({required this.repository});
  @override
  ResultFuture<void> call(ReAuthenticateWithEmailParams params) async =>
      await repository.reAuthenticateWithEmailAndPassword(
          email: params.email, password: params.password);
}

class ReAuthenticateWithEmailParams {
  final String email;
  final String password;

  ReAuthenticateWithEmailParams({required this.email, required this.password});
}
