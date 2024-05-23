import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/authentication/domain/usecases/get_current_user_data.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final GetCurrentUserData currentUserData;
  AppUserCubit({required this.currentUserData}) : super(AppUserInitial());

  void updateUser(UserEntity? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoaded(user));
    }
  }

  void getCurrentUserData() async {
    final userr = await currentUserData.call();
    userr.fold((l) {
      emit(AppUserFailure(error: l.message));
    }, (r) => emit(AppUserLoaded(r)));
  }

  @override
  void onChange(Change<AppUserState> change) {
    super.onChange(change);
    print("$change");
  }
}
