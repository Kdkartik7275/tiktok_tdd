import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/profile/domain/repository/user_repository.dart';

class FollowUser implements UseCaseWithParams<UserEntity, FollowUserParams> {
  final UserRepository repository;

  FollowUser({required this.repository});
  @override
  ResultFuture<UserEntity> call(FollowUserParams params) async =>
      await repository.followUser(
          userId: params.userId, myUserId: params.myUserId);
}

class FollowUserParams {
  final String userId;
  final String myUserId;

  FollowUserParams({required this.userId, required this.myUserId});
}
