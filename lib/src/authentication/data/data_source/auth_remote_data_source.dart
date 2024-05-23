import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/firebase_auth_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/firebase_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/format_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/platform_exceptions.dart';
import 'package:tiktok_tdd/src/authentication/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> loginUser(
      {required String email, required String password});

  Future<UserCredential> loginWithGoogle();
  // ResultFuture<UserCredential> loginWithFacebook();

  Future<UserCredential> registerUser(
      {required String email,
      required String password,
      required String username});

  Future<void> logoutUser();

  Future<User?> getCurrentUser();
  Future<void> deleteAccount();
  Future<void> sendVerificationMail();
  Future<void> reAuthenticateWithEmailAndPassword(
      {required String email, required String password});

  // --------------------- USER DATA --------------------------
  Future<String> uploadUserProfile(
      {required String path, required XFile image});

  Future<void> deleteUserData({required String userId});
  Future<void> updateSingleField({required Map<String, dynamic> json});

  Future<UserModel> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  AuthRemoteDataSourceImpl(
      {required FirebaseAuth auth,
      required FirebaseFirestore firestore,
      required FirebaseStorage storage})
      : _auth = auth,
        _firestore = firestore,
        _storage = storage;
  @override
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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

  @override
  Future<void> deleteUserData({required String userId}) async {
    try {
      return await _firestore.collection('Users').doc(userId).delete();
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
  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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

  @override
  Future<UserModel> getCurrentUserData() async {
    try {
      final documentSnapshot = await _firestore
          .collection('Users')
          .doc(_auth.currentUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromMap(documentSnapshot.data()!);
      } else {
        return UserModel.empty();
      }
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
  Future<UserCredential> loginUser(
      {required String email, required String password}) async {
    try {
     
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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

  @override
  Future<UserCredential> loginWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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

  @override
  Future<void> reAuthenticateWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      AuthCredential userCredenntial =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(userCredenntial);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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

  @override
  Future<UserCredential> registerUser(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (credential.user != null) {
        UserModel newUser = UserModel(
            username: username,
            email: email,
            uid: credential.user!.uid,
            bio: "",
            followers: [],
            followings: [],
            isActive: true,
            likesCount: 0,
            profilePic: "");
        await _firestore
            .collection('Users')
            .doc(credential.user!.uid)
            .set(newUser.toMap());
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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
  Future<void> sendVerificationMail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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

  @override
  Future<void> updateSingleField({required Map<String, dynamic> json}) async {
    try {
      return await _firestore
          .collection('Users')
          .doc(_auth.currentUser?.uid)
          .update(json);
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
  Future<String> uploadUserProfile(
      {required String path, required XFile image}) async {
    try {
      final ref = _storage.ref(path).child(image.name);
      await ref.putFile(File(image.path));

      final url = ref.getDownloadURL();
      return url;
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
