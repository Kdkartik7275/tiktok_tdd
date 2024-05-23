import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class GoogleLogin implements UseCaseWithoutParams<UserCredential> {
  final AuthRepository repository;

  GoogleLogin({required this.repository});
  @override
  ResultFuture<UserCredential> call() async =>
      await repository.loginWithGoogle();
}
