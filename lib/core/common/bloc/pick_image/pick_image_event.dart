part of 'pick_image_bloc.dart';

@immutable
sealed class PickImageEvent {}

final class PickFromGallery extends PickImageEvent {}

final class PickFromCamera extends PickImageEvent {}
