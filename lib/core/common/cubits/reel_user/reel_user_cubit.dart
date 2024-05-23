import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/profile/domain/usecases/follow_user.dart';
import 'package:tiktok_tdd/src/profile/domain/usecases/user_data.dart';

part 'reel_user_state.dart';

class ReelUserCubit extends Cubit<ReelUserState> {
  final GetUserData userData;
  final FollowUser followUser;
  ReelUserCubit({required this.userData, required this.followUser})
      : super(ReelUserInitial());

  void getUserData({required String userId}) async {
    emit(ReelUserLoading());
    final user = await userData.call(userId);
    user.fold(
        (l) => emit(ReelUserFailure()), (r) => emit(ReelUserLoaded(user: r)));
  }

  void follow({required String userId, required String myUserId}) async {
    final data = await followUser
        .call(FollowUserParams(userId: userId, myUserId: myUserId));
    data.fold((l) => null, (r) => null);
  }
}
