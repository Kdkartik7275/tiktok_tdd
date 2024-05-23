import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class SendVerificationMail implements UseCaseWithoutParams<void> {
  final AuthRepository repository;

  SendVerificationMail({required this.repository});
  @override
  ResultFuture<void> call() async => await repository.sendVerificationMail();
}
