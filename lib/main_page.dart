import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crop_sense/application/helpers/external_link_launcher.dart';
import 'package:crop_sense/application/home_page/home_page_bloc.dart';
import 'package:crop_sense/presentation/common/primary_button.dart';
import 'package:crop_sense/presentation/common/show_media_popup.dart';
import 'package:crop_sense/presentation/helpers/color_helper.dart';
import 'package:crop_sense/presentation/helpers/size_helper.dart';
import 'package:crop_sense/presentation/home/home_page.dart';
import 'package:crop_sense/presentation/side_drawer/side_drawer.dart';
import 'package:crop_sense/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'presentation/helpers/font_style_helper.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: AutoSizeText(
          'Crop Sense',
          style: kHeading22.copyWith(
            color: backgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) async {
          if (state is ContributeToUsButtonClickedState) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(
              msg: "Work under progress!",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.grey.shade300,
              textColor: primaryColor2,
            );
          }
          if (state is CropRecommendationFeatureClickedState) {
            await Get.dialog(
              Center(
                child: SizedBox(
                  height: 220,
                  width: displayWidth(context) * 0.8,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                        AutoSizeText(
                          "Please select one option to conitnue",
                          style: kHeading14,
                          maxLines: 2,
                          minFontSize: 1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: displayWidth(context) * 0.08,
                            vertical: 4,
                          ),
                          child: PrimaryButton(
                            title: "Take Data from Sensor",
                            onPressed: () {},
                            elevation: 0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: displayWidth(context) * 0.08,
                            vertical: 4,
                          ),
                          child: PrimaryButton(
                            title: "Enter your own Data",
                            onPressed: () {},
                            color: Colors.white,
                            textColor: Colors.black,
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is LetsExploreClickedState) {
            Navigator.of(context).pushNamed(Routes.featuresPage);
          }
          if (state is PlantsIOTImageClickedState) {
            await launchUrl("http://www.plantiot-ipu.in/");
          }
          if (state is IPULogoClickedState) {
            await launchUrl("http://www.ipu.ac.in/");
          }
          if (state is DiseaseDetectionClickedState) {
            Navigator.of(context).pushNamed(Routes.diseaseDetectionPage);
          }
          if (state is ChooseFileButtonClickedState) {
            showMediaPopup(
              onImage: (File? image) async {
                if (image != null) {
                  context.read<HomePageBloc>().add(FileSelectedEvent(image));
                }
              },
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: displayHeight(context) * 0.03,
                  horizontal: 30.0,
                ),
                child: const HomePage(),
              ),
            ),
          );
        },
      ),
    );
  }
}
