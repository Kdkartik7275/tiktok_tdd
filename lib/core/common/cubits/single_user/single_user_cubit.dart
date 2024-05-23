import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/profile/domain/usecases/follow_user.dart';
import 'package:tiktok_tdd/src/profile/domain/usecases/user_data.dart';

part 'single_user_state.dart';

class SingleUserCubit extends Cubit<SingleUserState> {
  final GetUserData userData;
  final FollowUser followUser;
  SingleUserCubit({required this.userData, required this.followUser})
      : super(SingleUserInitial());

  void getUserData({required String userId}) async {
    emit(SingleUserLoading());
    final user = await userData.call(userId);
    user.fold((l) => emit(SingleUserFailure()),
        (r) => emit(SingleUserLoaded(user: r)));
  }

  void follow({required String userId, required String myUserId}) async {
    final data = await followUser
        .call(FollowUserParams(userId: userId, myUserId: myUserId));
    data.fold((l) => null, (r) => null);
  }
}
