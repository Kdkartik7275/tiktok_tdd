part of 'upload_reel_bloc.dart';

sealed class UploadReelEvent extends Equatable {
  const UploadReelEvent();

  @override
  List<Object> get props => [];
}

final class OnUploadReel extends UploadReelEvent {
  final String userId;
  final String videoPath;
  final String caption;
  final String songName;

  const OnUploadReel(
      {required this.userId,
      required this.videoPath,
      required this.caption,
      required this.songName});
}
