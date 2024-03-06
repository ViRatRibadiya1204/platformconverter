import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final ImageHelper imageHelper = ImageHelper();

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<List<XFile?>> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
    bool multiple = false,
  }) async {
    if (multiple) {
      return await _imagePicker.pickMultiImage(imageQuality: imageQuality);
    }
    return [
      await _imagePicker.pickImage(source: source, imageQuality: imageQuality)
    ];
  }

  Future<CroppedFile?> crop({
    required XFile file,
    CropStyle cropStyle = CropStyle.circle,
  }) async =>
      await _imageCropper.cropImage(
        cropStyle: cropStyle,
        sourcePath: file.path,
      );
}

class contectdata {
  final String? name;
  final String? number;
  final String? chat;
  // final String? date;
  // final String? time;
  final File? image;
  var cdate;
  var ctime;
  contectdata({
    // required this.time,
    // required this.date,
    required this.name,
    required this.number,
    required this.chat,
    required this.image,
    required this.cdate,
    required this.ctime
  });
}

