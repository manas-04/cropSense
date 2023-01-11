import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/font_style_helper.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          AutoSizeText(
            title,
            style: kHeading14,
          ),
          AutoSizeText(
            " : ",
            style: kHeading14,
          ),
          AutoSizeText(
            value,
            style: kHeading14,
          )
        ],
      ),
    );
  }
}
