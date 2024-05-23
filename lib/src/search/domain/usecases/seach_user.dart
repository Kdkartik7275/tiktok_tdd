import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/search/domain/repository/search_repository.dart';

class SearchUser implements UseCaseWithParams<List<UserEntity>, String> {
  final SearchRepository repository;

  SearchUser({required this.repository});
  @override
  ResultFuture<List<UserEntity>> call(String params) async =>
      repository.searchUsers(query: params);
}
