import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';

abstract interface class SearchRepository {
  ResultFuture<List<UserEntity>> searchUsers({required String query});
}
