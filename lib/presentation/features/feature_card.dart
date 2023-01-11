import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../helpers/font_style_helper.dart';
import '../helpers/size_helper.dart';

class FeatureCard extends StatefulWidget {
  const FeatureCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    this.maxLines = 4,
    required this.ontap,
  });

  final String title;
  final String subTitle;
  final String image;
  final int maxLines;
  final Function() ontap;

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: EdgeInsets.symmetric(
        horizontal: displayWidth(context) * 0.04,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: widget.ontap,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  displayWidth(context) * 0.1,
                ),
                child: Image.asset(
                  widget.image,
                  width: displayWidth(context) * 0.24,
                  height: displayWidth(context) * 0.24,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.04,
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: AutoSizeText(
                        widget.title,
                        style: kHeading16,
                        maxLines: 1,
                        minFontSize: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Flexible(
                      child: AutoSizeText(
                        widget.subTitle,
                        style: kHeading12.copyWith(color: Colors.grey),
                        maxLines: widget.maxLines,
                        minFontSize: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
