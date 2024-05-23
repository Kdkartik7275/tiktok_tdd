import 'package:fpdart/fpdart.dart';
import 'package:tiktok_tdd/core/common/errors/failure.dart';
import 'package:tiktok_tdd/core/network/connection_checker.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/search/data/data_source/search_user_data_source.dart';
import 'package:tiktok_tdd/src/search/domain/repository/search_repository.dart';

class SearchUserRepositoryImpl implements SearchRepository {
  final ConnectionChecker connectionChecker;
  final SearchUserDataSource dataSource;

  SearchUserRepositoryImpl(
      {required this.connectionChecker, required this.dataSource});
  @override
  ResultFuture<List<UserEntity>> searchUsers({required String query}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final users = await dataSource.searchUser(query: query);
      return right(users);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }
}
