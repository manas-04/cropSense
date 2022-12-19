import 'package:flutter/material.dart';

import '../../helpers/color_helper.dart';
import '../../helpers/font_style_helper.dart';
import '../../helpers/size_helper.dart';

class DefaultTextBox extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Function? onChanged;
  final bool obscureText;
  final bool enabled;
  final Widget icon;
  final Color backgroundColor;

  const DefaultTextBox(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.labelText,
      required this.textEditingController,
      required this.textInputType,
      required this.backgroundColor,
      this.onChanged,
      required this.obscureText,
      required this.enabled})
      : super(key: key);

  @override
  _DefaultTextBoxState createState() => _DefaultTextBoxState();
}

class _DefaultTextBoxState extends State<DefaultTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: TextField(
          textCapitalization: TextCapitalization.words,
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          style: kHeading14,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: secondaryTextColor,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: widget.icon,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 18,
            ),
          ),
        ),
      ),
    );
  }
}
