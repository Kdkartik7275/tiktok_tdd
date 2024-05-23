part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object> get props => [];
}

final class AppUserInitial extends AppUserState {}

final class AppUserActionState extends AppUserState {}

final class AppUserToggleFollow extends AppUserActionState {}

final class AppUserLoaded extends AppUserState {
  final UserEntity user;
  const AppUserLoaded(this.user);
}

final class AppUserFailure extends AppUserState {
  final String error;

  const AppUserFailure({required this.error});
}
