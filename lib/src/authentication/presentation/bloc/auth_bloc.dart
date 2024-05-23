// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tiktok_tdd/src/authentication/domain/usecases/get_current_user.dart';
import 'package:tiktok_tdd/src/authentication/domain/usecases/login_user.dart';
import 'package:tiktok_tdd/src/authentication/domain/usecases/logout_user.dart';
import 'package:tiktok_tdd/src/authentication/domain/usecases/register_user.dart';
import 'package:tiktok_tdd/src/authentication/domain/usecases/update_single_field.dart';
import 'package:tiktok_tdd/src/authentication/domain/usecases/upload_user_profile.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUser registerUser;
  final LoginUser loginUser;
  final GetCurrentUser currentUser;
  final UpdateSingleField updateSingleField;
  final LogoutUser logoutUser;
  final UploadUserProfile userProfile;
  AuthBloc(
      {required this.registerUser,
      required this.userProfile,
      required this.loginUser,
      required this.logoutUser,
      required this.updateSingleField,
      required this.currentUser})
      : super(AuthInitial()) {
    on<AuthSignUp>(_registerUser);
    on<AuthLogin>(_loginUser);
    on<OnGetCurrenUser>(_currentUser);
    on<OnUserLogout>(_logout);
    on<OnAddUserProfileInfo>(_addProfileInfo);
  }

  FutureOr<void> _registerUser(
      AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    if (!event.formKey.currentState!.validate()) {
      emit(AuthInitial());
      return;
    }
    final registerRes = await registerUser.call(RegisterUserParams(
        email: event.email,
        password: event.password,
        username: event.username));
    registerRes.fold((l) => emit(AuthFailure(error: l.message)), (r) async {
      emit(AuthUserProfile(uid: r.user!.uid));
    });
  }

  FutureOr<void> _loginUser(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    if (!event.formKey.currentState!.validate()) {
      emit(AuthInitial());
      return;
    }
    final user = await loginUser
        .call(LoginUserParams(email: event.email, password: event.password));
    user.fold((l) => emit(AuthFailure(error: l.message)),
        (r) => emit(Authenticated(uid: r.user!.uid)));
  }

  FutureOr<void> _currentUser(
      OnGetCurrenUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await currentUser.call();
    user.fold((l) => emit(UnAuthenticated()),
        (r) => emit(Authenticated(uid: r!.uid)));
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print("$change");
  }

  FutureOr<void> _logout(OnUserLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await logoutUser.call();
    user.fold((l) => emit(AuthFailure(error: l.message)),
        (r) => emit(UnAuthenticated()));
  }

  FutureOr<void> _addProfileInfo(
      OnAddUserProfileInfo event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final profileUrl = await _uploadProfile(event.profile);
    final update = await updateSingleField
        .call({'bio': event.bio, 'profilePic': profileUrl});
    update.fold((l) => emit(AuthFailure(error: l.message)),
        (r) => emit(Authenticated(uid: event.uid)));
  }

  Future<String> _uploadProfile(XFile profile) async {
    String imageURl = "";
    final url = await userProfile.call(
        UploadProfileParams(path: "Users/Images/Profile", image: profile));
    url.fold((l) {
      imageURl = "";
    }, (r) {
      imageURl = r;
    });

    return imageURl;
  }
}
