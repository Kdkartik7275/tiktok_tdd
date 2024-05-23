import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/reel_entity.dart';
import 'package:tiktok_tdd/src/reels/domain/usecases/fetch_reels.dart';
import 'package:tiktok_tdd/src/reels/domain/usecases/like_reel.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  List<ReelEntity> reels = [];
  final FetchReels fetchReels;
  final LikeReel likeReel;
  ReelsBloc({required this.fetchReels, required this.likeReel})
      : super(ReelsInitial()) {
    on<OnHomeInit>(_homeInit);
    on<OnReelsScreenReturned>(_reelsScreenReturned);
    on<OnReelLikeEvent>(_toggleLike);
  }

  FutureOr<void> _homeInit(OnHomeInit event, Emitter<ReelsState> emit) async {
    emit(ReelsLoading());
    if (reels.isNotEmpty) {
      emit(ReelsLoaded(reels: reels));
      return;
    }
    final fetchedResponse = await fetchReels.call();
    fetchedResponse.fold((l) => emit(ReelsFaliure(error: l.message)),
        (r) => emit(ReelsLoaded(reels: r)));
  }

  Future<void> _reelsScreenReturned(
      OnReelsScreenReturned event, Emitter<ReelsState> emit) async {
    // Check if reels are already cached
    if (reels.isNotEmpty) {
      emit(ReelsLoaded(reels: reels));
      return;
    }

    // If not cached, fetch reels data
    emit(ReelsLoading());

    final fetchedResponse = await fetchReels.call();
    fetchedResponse.fold(
      (l) => emit(ReelsFaliure(error: l.message)),
      (r) {
        reels = r; // Cache the fetched reels data
        emit(ReelsLoaded(reels: r));
      },
    );
  }

  FutureOr<void> _toggleLike(
      OnReelLikeEvent event, Emitter<ReelsState> emit) async {
    emit(ReelsLikeActionState());
    int index = reels.indexWhere((element) => element.videoId == event.videoId);

    final likedReel = await likeReel
        .call(LikeReelParams(userId: event.userId, videoId: event.videoId));
    likedReel.fold((l) => emit(ReelsFaliure(error: l.message)), (reel) {
      reels[index] = reel;

      emit(ReelsLoaded(reels: reels));
    });
  }

  @override
  void onChange(Change<ReelsState> change) {
    super.onChange(change);
    print("$change");
  }
}
