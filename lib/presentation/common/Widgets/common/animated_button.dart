import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

import '../../../helpers/color_helper.dart';
import '../../../helpers/font_style_helper.dart';

class CustomAnimatedButton extends StatefulWidget {
  const CustomAnimatedButton({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    this.selectedTextColor,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    required this.onPressed,
  });

  final String title;
  final double height;
  final double width;
  final Color? selectedTextColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final Function onPressed;

  @override
  State<CustomAnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<CustomAnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      height: widget.height,
      width: widget.width,
      text: widget.title,
      isReverse: true,
      selectedTextColor: widget.selectedTextColor ?? Colors.black,
      transitionType: TransitionType.LEFT_TO_RIGHT,
      textStyle: kHeading18.copyWith(color: backgroundColor),
      backgroundColor: widget.backgroundColor ?? primaryColor2,
      borderColor: widget.borderColor ?? primaryColor2,
      borderRadius: widget.borderRadius ?? 10.0,
      borderWidth: 1,
      animationDuration: const Duration(milliseconds: 800),
      onPress: () {
        widget.onPressed();
      },
    );
  }
}
