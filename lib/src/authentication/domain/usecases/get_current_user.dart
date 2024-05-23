import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class GetCurrentUser implements UseCaseWithoutParams<User?> {
  final AuthRepository repository;

  GetCurrentUser({required this.repository});
  @override
  ResultFuture<User?> call() async => await repository.getCurrentUser();
}
