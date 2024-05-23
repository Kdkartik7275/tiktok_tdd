part of 'reels_bloc.dart';

sealed class ReelsState extends Equatable {
  const ReelsState();

  @override
  List<Object> get props => [];
}

final class ReelsInitial extends ReelsState {}

final class ReelsActionState extends ReelsState {}

final class ReelsLikeActionState extends ReelsActionState {}

final class ReelsLoading extends ReelsState {}

final class ReelsLoaded extends ReelsState {
  final List<ReelEntity> reels;

  const ReelsLoaded({required this.reels});
}

final class ReelsFaliure extends ReelsState {
  final String error;

  const ReelsFaliure({required this.error});
}
