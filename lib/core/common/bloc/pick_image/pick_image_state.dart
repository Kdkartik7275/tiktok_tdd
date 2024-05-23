part of 'pick_image_bloc.dart';

@immutable
sealed class PickImageState {}

final class PickImageInitial extends PickImageState {}

final class PickImageFile extends PickImageState {
  final XFile? image;

  PickImageFile({required this.image});
}
