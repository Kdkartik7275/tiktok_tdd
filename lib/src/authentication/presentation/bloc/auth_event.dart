part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  final GlobalKey<FormState> formKey;

  const AuthLogin(
      {required this.email, required this.password, required this.formKey});
}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final GlobalKey<FormState> formKey;

  const AuthSignUp(
      {required this.email,
      required this.password,
      required this.formKey,
      required this.username});
}

final class OnAddUserProfileInfo extends AuthEvent {
  final String bio;
  final XFile profile;
  final String uid;

  const OnAddUserProfileInfo(
      {required this.bio, required this.profile, required this.uid});
}

final class OnGetCurrenUser extends AuthEvent {}

final class OnUserLogout extends AuthEvent {}
