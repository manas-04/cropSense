import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/font_style_helper.dart';

class ErrorText extends StatelessWidget {
  final String error;
  final bool? showRetry;
  final Color? textColor;
  const ErrorText({
    Key? key,
    required this.error,
    this.showRetry,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 5,
          bottom: 5,
        ),
        child: AutoSizeText(
          error + (showRetry == true ? ". Tap to retry" : ""),
          style: kHeading10.copyWith(
            color: textColor ?? Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

void showErrorSnackbar({
  required String error,
}) {
  Get.closeAllSnackbars();
  Get.showSnackbar(GetSnackBar(
    message: error,
    backgroundColor: Colors.redAccent,
    duration: const Duration(seconds: 2),
  ));
}
