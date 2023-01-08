import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/color_helper.dart';
import '../helpers/font_style_helper.dart';

class PrimaryButton extends StatefulWidget {
  final String title;
  final Function()? onPressed;
  final Widget? titleWidget;
  final double? borderRadius;
  final Color? color;
  final Color? textColor;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double? elevation;

  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.titleWidget,
    this.borderRadius,
    this.color,
    this.textColor,
    this.padding,
    this.borderColor,
    this.elevation,
  }) : super(key: key);
  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: widget.elevation ?? 5,
              backgroundColor: widget.color ?? primaryColor2,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: widget.onPressed == null
                      ? Colors.grey.withOpacity(0.2)
                      : widget.borderColor ?? widget.color ?? primaryColor2,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 44),
              ),
            ),
            onPressed: widget.onPressed,
            child: widget.titleWidget ??
                Padding(
                  padding: widget.padding ??
                      const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
                      ),
                  child: AutoSizeText(
                    widget.title,
                    style: s16kPcw400.copyWith(
                      color: widget.onPressed == null
                          ? textColor2
                          : widget.textColor ?? Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    minFontSize: 1,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
