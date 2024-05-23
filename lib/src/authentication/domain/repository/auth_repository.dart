import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';

abstract interface class AuthRepository {
  ResultFuture<UserCredential> loginUser(
      {required String email, required String password});

  ResultFuture<UserCredential> loginWithGoogle();
  // ResultFuture<UserCredential> loginWithFacebook();

  ResultFuture<UserCredential> registerUser(
      {required String email,
      required String password,
      required String username});

  ResultVoid logoutUser();

  ResultFuture<User?> getCurrentUser();
  ResultVoid deleteAccount();
  ResultVoid sendVerificationMail();
  ResultVoid reAuthenticateWithEmailAndPassword(
      {required String email, required String password});

  // --------------------- USER DATA --------------------------
  ResultFuture<String> uploadUserProfile(
      {required String path, required XFile image});

  ResultVoid deleteUserData({required String userId});
  ResultVoid updateSingleField({required Map<String, dynamic> json});

  ResultFuture<UserEntity> getCurrentUserData();
}
