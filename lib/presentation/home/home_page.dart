import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:crop_sense/application/home_page/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/color_helper.dart';
import '../helpers/font_style_helper.dart';
import '../helpers/size_helper.dart';
import '../common/Widgets/common/animated_button.dart';
import '../common/Widgets/home_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: AutoSizeText(
              'In Association with',
              style: kHeading14.copyWith(
                color: primaryColor1,
              ),
              maxLines: 2,
              minFontSize: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Image.asset(
                  "assets/images/logoiot.png",
                  fit: BoxFit.contain,
                  width: displayWidth(context) * 0.27,
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Image.asset(
                  "assets/images/ggsipu.png",
                  width: displayWidth(context) * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AutoSizeText(
              'Smart Plant Disease Surveillance System',
              style: kHeading22.copyWith(
                color: primaryColor1,
              ),
              maxLines: 2,
              minFontSize: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DefaultTextStyle(
          style: kHeading16.copyWith(
            color: primaryColor2,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: AnimatedTextKit(
              totalRepeatCount: 1,
              animatedTexts: [
                TyperAnimatedText(
                  'We propose the practice of smart agriculture using automation and IoT technologies.',
                  speed: const Duration(milliseconds: 70),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const HomeCarousal(),
        const SizedBox(
          height: 18,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                context
                    .read<HomePageBloc>()
                    .add(CropRecommendationClickedEvent());
              },
              child: AutoSizeText(
                'Get Crop Recommendation',
                style: kHeading16.copyWith(
                  color: primaryColor1,
                  decoration: TextDecoration.underline,
                ),
                maxLines: 1,
                minFontSize: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomAnimatedButton(
          height: 50,
          borderRadius: 30,
          onPressed: () {
            Future.delayed(
              const Duration(milliseconds: 800),
              () {
                context.read<HomePageBloc>().add(
                      ContributeToUsButtonClickedEvent(),
                    );
              },
            );
          },
          title: 'Contribute to Us',
          width: displayWidth(context) * 0.6,
        ),
      ],
    );
  }
}
