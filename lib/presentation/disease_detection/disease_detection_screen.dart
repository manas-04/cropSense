import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crop_sense/application/home_page/home_page_bloc.dart';
import 'package:crop_sense/presentation/common/primary_button.dart';
import 'package:crop_sense/presentation/helpers/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/color_helper.dart';
import '../helpers/font_style_helper.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is FileSelectedState) {
          selectedImage = state.selectedImage;
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
                          : const Center(
                              child: Icon(
                                Icons.add_circle_outline_rounded,
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    title: "Choose File",
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
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    title: "Predict",
                    onPressed: selectedImage != null ? () {} : null,
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
