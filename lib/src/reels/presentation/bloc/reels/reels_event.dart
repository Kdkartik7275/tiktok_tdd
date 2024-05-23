part of 'reels_bloc.dart';

sealed class ReelsEvent extends Equatable {
  const ReelsEvent();

  @override
  List<Object> get props => [];
}

final class OnHomeInit extends ReelsEvent {}

final class OnReelsScreenReturned extends ReelsEvent {}

final class OnReelLikeEvent extends ReelsEvent {
  final String videoId;
  final String userId;

  const OnReelLikeEvent({required this.videoId, required this.userId});
}
