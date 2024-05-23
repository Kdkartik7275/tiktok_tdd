import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/repository/auth_repository.dart';

class UploadUserProfile
    implements UseCaseWithParams<String, UploadProfileParams> {
  final AuthRepository repository;

  UploadUserProfile({required this.repository});

  @override
  ResultFuture<String> call(UploadProfileParams params) async =>
      await repository.uploadUserProfile(
          path: params.path, image: params.image);
}

class UploadProfileParams {
  final String path;
  final XFile image;

  UploadProfileParams({required this.path, required this.image});
}
