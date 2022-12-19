import 'package:flutter/material.dart';

import '../helpers/color_helper.dart';

class LoadingIndicator extends StatelessWidget {
  final bool showLoadingText;
  final String customText;
  final double size;

  const LoadingIndicator({
    Key? key,
    this.showLoadingText = false,
    this.size = 30,
    this.customText = "Loading...",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size,
              width: size,
              child: const FittedBox(
                fit: BoxFit.fitHeight,
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(primaryColor2),
                ),
              ),
            ),
            showLoadingText
                ? const SizedBox(
                    height: 10,
                  )
                : const SizedBox(),
            showLoadingText
                ? Text(
                    customText,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
