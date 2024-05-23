import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/firebase_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/format_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/platform_exceptions.dart';
import 'package:tiktok_tdd/src/authentication/data/models/user_model.dart';

abstract interface class UserRemoteDataSource {
  Future<UserModel> followUser(
      {required String userId, required String myUserId});

  Future<UserModel> getUserData({required String userId});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  UserRemoteDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;
  @override
  Future<UserModel> followUser(
      {required String userId, required String myUserId}) async {
    try {
      var followersDoc = await _firestore.collection('Users').doc(userId).get();
      if (followersDoc.data()!['followers'].contains(myUserId)) {
        await _firestore.collection('Users').doc(userId).update({
          'followers': FieldValue.arrayRemove([myUserId])
        });
        await _firestore.collection('Users').doc(myUserId).update({
          'followings': FieldValue.arrayRemove([userId])
        });
      } else {
        await _firestore.collection('Users').doc(userId).update({
          'followers': FieldValue.arrayUnion([myUserId])
        });
        await _firestore.collection('Users').doc(myUserId).update({
          'followings': FieldValue.arrayUnion([userId])
        });
      }
      var updatedUserData =
          await _firestore.collection('Users').doc(userId).get();
      UserModel updatedUser = UserModel.fromMap(updatedUserData.data()!);
      return updatedUser;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Future<UserModel> getUserData({required String userId}) async {
    try {
      final data = await _firestore.collection('Users').doc(userId).get();
      UserModel user = UserModel.fromMap(data.data()!);
      return user;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
