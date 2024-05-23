part of 'single_user_cubit.dart';

sealed class SingleUserState extends Equatable {
  const SingleUserState();

  @override
  List<Object> get props => [];
}

final class SingleUserInitial extends SingleUserState {}

final class SingleUserLoading extends SingleUserState {}

final class SingleUserActionState extends SingleUserState {}

final class UserFollowState extends SingleUserActionState {}

final class SingleUserLoaded extends SingleUserState {
  final UserEntity user;

  const SingleUserLoaded({required this.user});
}

final class SingleUserFailure extends SingleUserState {}
