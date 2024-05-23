import 'package:fpdart/fpdart.dart';
import 'package:tiktok_tdd/core/common/errors/failure.dart';
import 'package:tiktok_tdd/core/network/connection_checker.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/profile/data/data_source/user_remote_data_source.dart';
import 'package:tiktok_tdd/src/profile/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userDataSource;
  final ConnectionChecker connectionChecker;

  UserRepositoryImpl(
      {required this.userDataSource, required this.connectionChecker});
  @override
  ResultFuture<UserEntity> followUser(
      {required String userId, required String myUserId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final user =
          await userDataSource.followUser(userId: userId, myUserId: myUserId);
      return right(user);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<UserEntity> getUserData({required String userId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final user = await userDataSource.getUserData(userId: userId);
      return right(user);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }
}
