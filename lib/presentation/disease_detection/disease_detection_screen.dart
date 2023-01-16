import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:crop_sense/application/home_page/home_page_bloc.dart';
import 'package:crop_sense/presentation/common/lottie_animator.dart';
import 'package:crop_sense/presentation/common/primary_button.dart';
import 'package:crop_sense/presentation/helpers/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/color_helper.dart';
import '../helpers/font_style_helper.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File? selectedImage;
  bool isPredictionLoading = false;
  bool predictedOnce = false;
  bool showResult = false;
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is FileSelectedState) {
          selectedImage = state.selectedImage;
        }
        if (state is PredictLoadingState) {
          isPredictionLoading = true;
        }
        if (state is PredictionErrorState) {
          isPredictionLoading = false;
          Fluttertoast.cancel();
          Fluttertoast.showToast(msg: state.error);
        }
        if (state is PredictionSuccessfulState) {
          predictedOnce = true;
          isPredictionLoading = false;
          showResult = true;
          answer = state.answer;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: AutoSizeText(
              'Plant Disease Detection',
              style: kHeading22.copyWith(
                color: backgroundColor,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: displayWidth(context) * 0.07,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: displayHeight(context) * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<HomePageBloc>()
                          .add(ChooseFileButtonClickedEvent());
                    },
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.withOpacity(0.6),
                      ),
                      child: selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                AutoSizeText(
                                  "No Image is selected yet!",
                                  style: kHeading14,
                                )
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    title:
                        predictedOnce ? "Choose Another File" : "Choose File",
                    onPressed: () {
                      context
                          .read<HomePageBloc>()
                          .add(ChooseFileButtonClickedEvent());
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: displayHeight(context) * 0.02,
                    ),
                    child: AutoSizeText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "Steps to follow :\n\n", style: kHeading16),
                          const TextSpan(
                            text:
                                "1. Click on 'Choose a file Button' to select an Image.\n",
                          ),
                          const TextSpan(
                            text:
                                "2. After the content of the Preview Box has changed to the selected image, click on Predict Button.\n",
                          ),
                          const TextSpan(
                            text:
                                "3. Wait for a minute for the image to process, after that the result will be shown on the screen.",
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                      style: kHeading14,
                    ),
                  ),
                  SizedBox(
                    height: isPredictionLoading ? 0 : 20,
                  ),
                  showResult
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: DefaultTextStyle(
                            style: kHeading16.copyWith(
                              color: primaryColor2,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: AnimatedTextKit(
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    'Predicted Result : $answer',
                                    speed: const Duration(
                                      milliseconds: 70,
                                    ),
                                    textStyle: kHeading18.copyWith(
                                      color: primaryColor1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  isPredictionLoading
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LottieAnimation(
                                asset: "assets/animations/plant.json",
                                height: displayWidth(context) * 0.46,
                                width: displayWidth(context) * 0.46,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              AutoSizeText(
                                "Please be Paitent, this will take some time",
                                style: kHeading14,
                                maxLines: 1,
                                minFontSize: 1,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      : PrimaryButton(
                          title: predictedOnce ? "Predict Again" : "Predict",
                          onPressed: selectedImage != null
                              ? () {
                                  context
                                      .read<HomePageBloc>()
                                      .add(PredictClickedEvent(selectedImage!));
                                }
                              : null,
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
