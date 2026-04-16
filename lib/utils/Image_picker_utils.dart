import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  ImagePicker imagePicker = ImagePicker();

  cameraCapture() async {
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    return file;
  }

  imageFromGallery() async {
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    return file;
  }
}
