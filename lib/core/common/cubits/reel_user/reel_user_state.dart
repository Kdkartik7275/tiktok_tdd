part of 'reel_user_cubit.dart';

sealed class ReelUserState extends Equatable {
  const ReelUserState();

  @override
  List<Object> get props => [];
}

final class ReelUserInitial extends ReelUserState {}

final class ReelUserLoading extends ReelUserState {}

final class ReelUserActionState extends ReelUserState {}

final class UserFollowState extends ReelUserActionState {}

final class ReelUserLoaded extends ReelUserState {
  final UserEntity user;

  const ReelUserLoaded({required this.user});
}

final class ReelUserFailure extends ReelUserState {}
