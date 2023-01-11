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
  SensorDataResponse? data;

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
              ? Center(
                  child: LottieAnimation(
                    asset: "assets/animations/plant_and_hand.json",
                    height: displayWidth(context) * 0.4,
                    width: displayWidth(context) * 0.4,
                  ),
                )
              : isError
                  ? Center(
                      child: ErrorText(error: error),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Column(
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
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: PrimaryButton(
                              title: "Get Recommendations",
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              child: InkWell(
                                onTap: () {},
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
        );
      },
    );
  }
}
