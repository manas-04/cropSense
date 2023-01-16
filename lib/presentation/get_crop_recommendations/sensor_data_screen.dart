import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crop_sense/domain/recommendation/recommendation_response.dart';
import 'package:crop_sense/presentation/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:crop_sense/domain/sensor_data/sensor_data_response.dart';
import 'package:crop_sense/presentation/common/error_text.dart';
import 'package:crop_sense/presentation/common/lottie_animator.dart';
import 'package:crop_sense/presentation/get_crop_recommendations/details_row.dart';
import 'package:crop_sense/presentation/helpers/size_helper.dart';

import '../../application/home_page/home_page_bloc.dart';
import '../helpers/color_helper.dart';
import '../helpers/font_style_helper.dart';

class SensorDataScreen extends StatefulWidget {
  const SensorDataScreen({super.key});

  @override
  State<SensorDataScreen> createState() => _SensorDataScreenState();
}

class _SensorDataScreenState extends State<SensorDataScreen> {
  bool isLoading = true;
  bool isError = false;
  String error = '';
  bool isCropLoading = false;
  bool isCropError = false;
  String cropError = '';
  bool showCropRecommendedSection = false;
  SensorDataResponse? data;
  RecommendationResponse? res;

  @override
  void initState() {
    super.initState();
    context.read<HomePageBloc>().add(FetchDataFromSensor());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is DataFromSensorLoadingState) {
          isLoading = true;
          isError = false;
        }
        if (state is DataFromSensorLoadedState) {
          data = state.data;
          isLoading = false;
          isError = false;
        }
        if (state is DataFromSensorErrorState) {
          error = state.error;
          isError = true;
          isLoading = false;
        }
        if (state is GetRecommendationDataFromSensorLoadingState) {
          showCropRecommendedSection = true;
          isCropLoading = true;
          isCropError = false;
        }
        if (state is GetRecommendationDataFromSensorLoadedState) {
          res = state.data;
          showCropRecommendedSection = true;
          isCropLoading = false;
          isCropError = false;
        }
        if (state is GetRecommendationDataFromSensorErrorState) {
          showCropRecommendedSection = true;
          cropError = state.error;
          isCropError = true;
          isCropLoading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: AutoSizeText(
              'Crop Recommendation',
              style: kHeading22.copyWith(
                color: backgroundColor,
              ),
            ),
            centerTitle: true,
          ),
          body: isLoading
              ? SizedBox(
                  width: displayWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieAnimation(
                        asset: "assets/animations/plant_and_hand.json",
                        height: displayWidth(context) * 0.4,
                        width: displayWidth(context) * 0.4,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      AutoSizeText(
                        "We are processing your request.",
                        style: kHeading18,
                      )
                    ],
                  ),
                )
              : isError
                  ? InkWell(
                      onTap: () {
                        context.read<HomePageBloc>().add(FetchDataFromSensor());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: displayHeight(context) * 0.1,
                          horizontal: displayWidth(context) * 0.1,
                        ),
                        child: ErrorText(
                          error: cropError,
                          showRetry: true,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              "Current Details",
                              style: kHeading18,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  DetailsRow(
                                    title: "Weather Location",
                                    value: data!.weatherLocation,
                                  ),
                                  DetailsRow(
                                    title: "Moisture",
                                    value: data!.moisture,
                                  ),
                                  DetailsRow(
                                    title: "Soil Temperature",
                                    value: data!.soilTemp,
                                  ),
                                  DetailsRow(
                                    title: "Weather Temperature",
                                    value: data!.weatherTemp.toString(),
                                  ),
                                  DetailsRow(
                                    title: "Weather Condition",
                                    value: data!.weatherCond,
                                  ),
                                  DetailsRow(
                                    title: "Weather Humidity",
                                    value: data!.weatherHumidity.toString(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            showCropRecommendedSection
                                ? isCropLoading
                                    ? isCropError
                                        ? InkWell(
                                            onTap: () {
                                              context.read<HomePageBloc>().add(
                                                  GetRecommendationDataFromSensorEvent());
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    displayHeight(context) *
                                                        0.1,
                                                horizontal:
                                                    displayWidth(context) * 0.1,
                                              ),
                                              child: ErrorText(
                                                error: cropError,
                                                showRetry: true,
                                              ),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              LottieAnimation(
                                                asset:
                                                    "assets/animations/Planta_0.json",
                                                height:
                                                    displayWidth(context) * 0.6,
                                                width:
                                                    displayWidth(context) * 0.6,
                                              ),
                                              const SizedBox(
                                                height: 14,
                                              ),
                                              AutoSizeText(
                                                "Please be Paitent, this will take some time",
                                                style: kHeading16,
                                                maxLines: 1,
                                                minFontSize: 1,
                                              ),
                                              const SizedBox(
                                                height: 14,
                                              ),
                                            ],
                                          )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          DefaultTextStyle(
                                            style: kHeading16.copyWith(
                                              color: primaryColor2,
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AnimatedTextKit(
                                                totalRepeatCount: 1,
                                                animatedTexts: [
                                                  TyperAnimatedText(
                                                    'Recommended Crop is : ${res!.predictedCrop}',
                                                    speed: const Duration(
                                                      milliseconds: 60,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 14,
                                          ),
                                        ],
                                      )
                                : const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: PrimaryButton(
                                title: "Get Recommendations",
                                onPressed: () {
                                  context.read<HomePageBloc>().add(
                                      GetRecommendationDataFromSensorEvent());
                                },
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<HomePageBloc>()
                                        .add(EnterYourOwnDataEvent());
                                  },
                                  child: AutoSizeText(
                                    "Enter your own details",
                                    style: kHeading14.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
