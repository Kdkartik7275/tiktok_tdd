import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class LoginUser implements UseCaseWithParams<UserCredential, LoginUserParams> {
  final AuthRepository repository;

  LoginUser({required this.repository});
  @override
  ResultFuture<UserCredential> call(LoginUserParams params) async =>
      await repository.loginUser(
          email: params.email, password: params.password);
}

class LoginUserParams {
  final String email;
  final String password;

  LoginUserParams({required this.email, required this.password});
}
