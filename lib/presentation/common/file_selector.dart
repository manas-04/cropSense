import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../helpers/color_helper.dart';

class FileSelector {
  final logger = Logger();
  final picker = ImagePicker();

  Future<File?> getImageFromGallery(
      {required BuildContext ctx, File? imageType}) async {
    // File image;
    Navigator.pop(ctx);

    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['jpg', 'jpeg', 'png'],
    //   allowMultiple: false,
    //   allowCompression: true,
    // );
    final result = await AssetPicker.pickAssets(
      ctx,
      pickerConfig: const AssetPickerConfig(
        themeColor: primaryColor2,
        maxAssets: 1,
      ),
    );

    if (result == null) {
      return null;
    }
    File? image = await result.first.file;
    // if (result.files.first.size / (1024 * 1024) >= 15) {
    //   Fluttertoast.showToast(msg: "Please select a smaller size!");
    // }
    // image = File(result.files.first.path!);
    return image;
  }

  Future<File?> getImageFromCamera({
    required BuildContext ctx,
    File? imageType,
    double? maxHeight,
    double? maxWidth,
  }) async {
    logger.d("Inside the Camera function!");
    File? imageFromCamera;

    Navigator.pop(ctx);
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    // final File? result = await Get.to(
    //   () => CameraCamera(
    //     onFile: (file) {
    //       Get.back(result: file);
    //     },
    //     cameraSide: CameraSide.all,
    //     flashModes: const [],
    //   ),
    // );
    logger.d('Image Chosen from Camera');
    if (pickedImage != null) {
      imageFromCamera = File(pickedImage.path);
      return imageFromCamera;
    } else {
      Fluttertoast.showToast(msg: "No Image selected!");
    }
    // if (result != null) {
    //   imageFromCamera = result;
    //   return imageFromCamera;
    // } else {
    //   Fluttertoast.showToast(msg: "No Image selected!");
    // }

    return imageFromCamera;
  }

  // Future<File> getPdf(BuildContext ctx) async {
  //   logger.d('Inside the PDF Function');
  //   File pdf;
  //   Navigator.pop(ctx);

  //   FilePickerResult result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //     allowMultiple: false,
  //   );

  //   logger.d('Chosen the PDF');
  //   if (result.files.first.size / (1024 * 1024) >= 15) {
  //     Fluttertoast.showToast(msg: "Please select a smaller size!");
  //   }
  //   pdf = File(result.files.first.path);
  //   return pdf;
  // }
}
