part of 'search_user_bloc.dart';

sealed class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

final class OnSearchEvent extends SearchUserEvent {
  final String query;

  const OnSearchEvent({required this.query});
}

final class ClearUsers extends SearchUserEvent {}
