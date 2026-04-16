import 'package:bloc_pattern/bloc/image_picker/image_picker_event.dart';
import 'package:bloc_pattern/bloc/image_picker/image_picker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/Image_picker_utils.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;

  ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerState()) {
    on<CameraCaptureEvent>((event, emit) async {
      XFile file = await imagePickerUtils.cameraCapture();
      emit(state.copyWith(file: file));
    });

    on<GalleryPickerEvent>(galleryPicker);
  }

  Future<void> galleryPicker(GalleryPickerEvent event, Emitter<ImagePickerState> emit) async {
    XFile file = await imagePickerUtils.imageFromGallery();
    emit(state.copyWith(file: file));
  }
}
