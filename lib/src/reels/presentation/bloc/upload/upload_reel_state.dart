part of 'upload_reel_bloc.dart';

sealed class UploadReelState extends Equatable {
  const UploadReelState();

  @override
  List<Object> get props => [];
}

final class UploadReelInitial extends UploadReelState {}

final class UploadReelLoading extends UploadReelState {}

final class UploadReelSuccess extends UploadReelState {}

final class UploadReelFailure extends UploadReelState {
  final String error;

  const UploadReelFailure({required this.error});
}
