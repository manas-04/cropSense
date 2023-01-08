import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helpers/font_style_helper.dart';
import '../helpers/size_helper.dart';

class CustomIconListTile extends StatelessWidget {
  const CustomIconListTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.press,
  }) : super(key: key);
  final String icon, text;
  final Color color;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: displayHeight(context) * 0.02,
          bottom: displayHeight(context) * 0.02,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: icon.endsWith(".png")
                  ? Image.asset(
                      icon,
                      fit: BoxFit.contain,
                      color: color,
                    )
                  : SvgPicture.asset(
                      icon,
                      fit: BoxFit.contain,
                      color: color,
                    ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: AutoSizeText(
                text,
                style: kHeading14,
                minFontSize: 1,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
