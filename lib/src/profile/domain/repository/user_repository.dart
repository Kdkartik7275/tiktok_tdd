import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';

abstract interface class UserRepository {
  ResultFuture<UserEntity> followUser(
      {required String userId, required String myUserId});

  ResultFuture<UserEntity> getUserData({required String userId});
}
