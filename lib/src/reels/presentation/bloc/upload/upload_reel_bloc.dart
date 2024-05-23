import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiktok_tdd/src/reels/domain/usecases/upload_reel.dart';

part 'upload_reel_event.dart';
part 'upload_reel_state.dart';

class UploadReelBloc extends Bloc<UploadReelEvent, UploadReelState> {
  final UploadReel uploadReel;
  UploadReelBloc({required this.uploadReel}) : super(UploadReelInitial()) {
    on<OnUploadReel>(_uploadReel);
  }

  FutureOr<void> _uploadReel(
      OnUploadReel event, Emitter<UploadReelState> emit) async {
    emit(UploadReelLoading());

    final uploading = await uploadReel.call(UploadReelParams(
        userId: event.userId,
        videoPath: event.videoPath,
        caption: event.caption,
        songName: event.songName));
    uploading.fold((l) => emit(UploadReelFailure(error: l.message)),
        (r) => emit(UploadReelSuccess()));
  }
}
