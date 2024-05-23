import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class UpdateSingleField
    implements UseCaseWithParams<void, Map<String, dynamic>> {
  final AuthRepository repository;

  UpdateSingleField({required this.repository});
  @override
  ResultFuture<void> call(Map<String, dynamic> params) async =>
      await repository.updateSingleField(json: params);
}
