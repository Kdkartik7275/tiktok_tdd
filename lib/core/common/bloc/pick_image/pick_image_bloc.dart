import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tdd/core/utils/helper_functions/functions.dart';

part 'pick_image_event.dart';
part 'pick_image_state.dart';

class PickImageBloc extends Bloc<PickImageEvent, PickImageState> {
  final TFunctions functions;
  PickImageBloc(
    this.functions,
  ) : super(PickImageInitial()) {
    on<PickFromGallery>(_pickFromGallery);
    on<PickFromCamera>(_pickFromCamera);
  }

  void _pickFromGallery(
      PickFromGallery event, Emitter<PickImageState> emit) async {
    final image = await functions.getImage(ImageSource.gallery);
    if (image != null) {
      emit(PickImageFile(image: image));
    }
  }

  void _pickFromCamera(
      PickFromCamera event, Emitter<PickImageState> emit) async {
    final image = await functions.getImage(ImageSource.camera);
    if (image != null) {
      emit(PickImageFile(image: image));
    }
  }
}
