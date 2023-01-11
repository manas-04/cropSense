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
    Navigator.pop(ctx);
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
    logger.d('Image Chosen from Camera');
    if (pickedImage != null) {
      imageFromCamera = File(pickedImage.path);
      return imageFromCamera;
    } else {
      Fluttertoast.showToast(msg: "No Image selected!");
    }
    return imageFromCamera;
  }
}
