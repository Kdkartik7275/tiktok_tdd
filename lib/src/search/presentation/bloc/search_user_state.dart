part of 'search_user_bloc.dart';

sealed class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object> get props => [];
}

final class SearchUserInitial extends SearchUserState {}

final class SearchUserLoading extends SearchUserState {}

final class SearchUserLoaded extends SearchUserState {
  final List<UserEntity> users;

  const SearchUserLoaded({required this.users});
}

final class SearchUserFailure extends SearchUserState {
  final String error;

  const SearchUserFailure({required this.error});
}
