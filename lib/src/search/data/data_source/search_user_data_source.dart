import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/firebase_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/format_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/platform_exceptions.dart';
import 'package:tiktok_tdd/src/authentication/data/models/user_model.dart';

abstract interface class SearchUserDataSource {
  Future<List<UserModel>> searchUser({required String query});
}

class SearchUserDataSourceImpl implements SearchUserDataSource {
  final FirebaseFirestore _firestore;

  SearchUserDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;
  @override
  Future<List<UserModel>> searchUser({required String query}) async {
    try {
      final results = await _firestore
          .collection('Users')
          .where("username", isGreaterThanOrEqualTo: query)
          .get();
      List<UserModel> users = [];
      for (var item in results.docs) {
        users.add(UserModel.fromMap((item.data())));
      }
      return users;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
