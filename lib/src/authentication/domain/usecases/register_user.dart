import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class RegisterUser
    implements UseCaseWithParams<UserCredential, RegisterUserParams> {
  final AuthRepository repository;

  RegisterUser({required this.repository});

  @override
  ResultFuture<UserCredential> call(RegisterUserParams params) async =>
      await repository.registerUser(
          email: params.email,
          password: params.password,
          username: params.username);
}

class RegisterUserParams {
  final String email;
  final String password;
  final String username;

  RegisterUserParams(
      {required this.email, required this.password, required this.username});
}
