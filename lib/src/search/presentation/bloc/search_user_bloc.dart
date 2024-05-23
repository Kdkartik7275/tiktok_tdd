// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/search/domain/usecases/seach_user.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final SearchUser searchUser;
  SearchUserBloc({required this.searchUser}) : super(SearchUserInitial()) {
    on<OnSearchEvent>(_searchUser);
    on<ClearUsers>(clearUsers);
  }

  FutureOr<void> _searchUser(
      OnSearchEvent event, Emitter<SearchUserState> emit) async {
    if (event.query != "") {
      emit(SearchUserLoading());

      final users = await searchUser.call(event.query);
      users.fold((l) => emit(SearchUserFailure(error: l.message)),
          (r) => emit(SearchUserLoaded(users: r)));
    }
  }

  void clearUsers(ClearUsers event, Emitter<SearchUserState> emit) {
    emit(SearchUserLoading());
    emit(const SearchUserLoaded(users: []));
  }
}
