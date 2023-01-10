import 'dart:io';

import 'package:crop_sense/presentation/common/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

Future<void> showMediaPopup({
  required Function onImage,
  double? maxHeight,
  double? maxWidth,
}) async {
  final FileSelector fileSelector = FileSelector();
  BuildContext context = Get.context as BuildContext;
  await Get.dialog(
    AlertDialog(
      title: const Center(
        child: Text(
          'Choose Media',
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              File? selectedImage;
              File? img = await fileSelector.getImageFromCamera(ctx: context);
              if (img != null) {
                selectedImage = await compressImage(img);
              } else {
                selectedImage = img;
              }
              await onImage(selectedImage);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/images/camera.svg",
                ),
                const Text(
                  'Capture',
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              File? selectedImage;
              File? img = await fileSelector.getImageFromGallery(ctx: context);
              if (img != null) {
                selectedImage = await compressImage(img);
              } else {
                selectedImage = img;
              }
              await onImage(selectedImage);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/images/gallery.svg",
                ),
                const Text(
                  'Gallery',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<File?> compressImage(File file) async {
  final temp = await getTemporaryDirectory();
  final currentPath = file.absolute.path;
  final fileName = currentPath.split('/').last;
  final outputPath = "${temp.path}/compressed_$fileName";

  final compressedImage = await FlutterImageCompress.compressAndGetFile(
    currentPath,
    outputPath,
    minWidth: 256,
    minHeight: 256,
    quality: 95,
  );

  return compressedImage;
}
