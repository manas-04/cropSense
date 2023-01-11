import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:crop_sense/domain/recommendation/recommendation_response.dart';
import 'package:crop_sense/presentation/common/error_text.dart';
import 'package:crop_sense/presentation/common/recommendation_carousel.dart';
import 'package:crop_sense/presentation/helpers/font_style_helper.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../application/recommedation/recommendation_bloc.dart';
import '../common/animated_button.dart';
import '../common/default_text_box.dart';
import '../common/loading_indicator.dart';
import '../helpers/color_helper.dart';
import '../helpers/size_helper.dart';

class CropRecommendationsPage extends StatefulWidget {
  const CropRecommendationsPage({Key? key}) : super(key: key);

  @override
  State<CropRecommendationsPage> createState() =>
      _CropRecommendationsPageState();
}

class _CropRecommendationsPageState extends State<CropRecommendationsPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _rainfallController = TextEditingController();
  final TextEditingController _phLevelController = TextEditingController();
  final TextEditingController _nitrogenController = TextEditingController();
  final TextEditingController _phosphorusController = TextEditingController();
  final TextEditingController _potassiumController = TextEditingController();

  final FocusNode potassiumFocusNode = FocusNode();

  late TabController tabController = TabController(
    length: 2,
    vsync: this,
  );
  bool tabControllerListenerSetted = false;

  String? countryName;
  String? stateName;
  String? cityName;

  bool isLoading = false;
  bool isError = false;
  String error = '';
  RecommendationResponse? crop;
  bool showResult = false;

  @override
  void dispose() {
    _nitrogenController.dispose();
    _phLevelController.dispose();
    _phosphorusController.dispose();
    _potassiumController.dispose();
    _rainfallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecommendationBloc(InitialRecommendationState()),
      child: BlocConsumer<RecommendationBloc, RecommendationState>(
        listener: (context, state) {
          if (state is CountryChangeState) {
            countryName = state.countryName;
          }
          if (state is StateChangeState) {
            stateName = state.stateName;
          }
          if (state is CityChangeState) {
            cityName = state.cityName;
          }
          if (state is NextButtonClickedState) {
            Fluttertoast.cancel();
            if (state.countryName == null || state.countryName == '') {
              Fluttertoast.showToast(
                msg: 'Please enter country name!',
                backgroundColor: errorColor,
                textColor: backgroundColor,
              );
            } else if (state.stateName == null || state.stateName == '') {
              Fluttertoast.showToast(
                msg: 'Please enter state name!',
                backgroundColor: errorColor,
                textColor: backgroundColor,
              );
            } else {
              context.read<RecommendationBloc>().add(ChangeTabIndexEvent());
            }
          }
          if (state is ChangeTabIndexState) {
            tabController.index = 1;
          }
          if (state is SubmitRecommendationFormClickedState) {
            potassiumFocusNode.unfocus();
            Fluttertoast.cancel();
            if (state.phLevel == null || state.phLevel == '') {
              Fluttertoast.showToast(
                msg: 'Please enter phLevel of Soil!',
                backgroundColor: errorColor,
                textColor: backgroundColor,
              );
            } else if (state.rainfallLevel == null ||
                state.rainfallLevel == '') {
              Fluttertoast.showToast(
                msg: 'Please enter rainfall level!',
                backgroundColor: errorColor,
                textColor: backgroundColor,
              );
            } else if (state.nitrgoenLevel == null ||
                state.nitrgoenLevel == '') {
              Fluttertoast.showToast(
                msg: 'Please enter nitrogen level!',
                backgroundColor: errorColor,
                textColor: backgroundColor,
              );
            } else if (state.phosphorusLevel == null ||
                state.phosphorusLevel == '') {
              Fluttertoast.showToast(
                msg: 'Please enter phosphorus level!',
                backgroundColor: errorColor,
                textColor: backgroundColor,
              );
            } else if (state.potassiumLevel == null ||
                state.potassiumLevel == '') {
              Fluttertoast.showToast(
                msg: 'Please enter potassium level!',
                backgroundColor: errorColor,
                textColor: backgroundColor,
              );
            } else if (int.parse(state.phLevel!) > 14 ||
                int.parse(state.phLevel!) < 0) {
              Fluttertoast.showToast(
                msg: 'Please enter a valid pH Level value!',
                backgroundColor: errorColor,
                textColor: backgroundColor,
              );
            } else {
              context.read<RecommendationBloc>().add(
                    SubmitDataToBackendEvent(
                      cityName: cityName!,
                      countryName: countryName!,
                      stateName: stateName!,
                      rainfallLevel: _rainfallController.text,
                      nitrgoenLevel: _nitrogenController.text,
                      phLevel: _phLevelController.text,
                      phosphorusLevel: _phosphorusController.text,
                      potassiumLevel: _potassiumController.text,
                    ),
                  );
            }
          }
          if (state is FetchRecommendedCropLoadingState) {
            showResult = false;
            isError = false;
            isLoading = true;
          }
          if (state is FetchRecommendedCropErrorState) {
            showResult = false;
            error = state.error;
            isError = true;
            isLoading = false;
          }
          if (state is FetchRecommendedCropLoadedState) {
            crop = state.crop;
            showResult = true;
            isError = false;
            isLoading = false;
          }
        },
        builder: (context, state) {
          if (!tabControllerListenerSetted) {
            tabControllerListenerSetted = true;
            tabController.addListener(() {
              if (!tabController.indexIsChanging) {
                context.read<RecommendationBloc>().add(
                      RecommendationIndexChangedEvent(
                        tabController.index,
                      ),
                    );
              }
            });
          }
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: primaryColor2.withOpacity(0.8),
              title: AutoSizeText(
                'Crop Sense',
                maxLines: 1,
                style: kHeading18.copyWith(color: backgroundColor),
              ),
              centerTitle: true,
            ),
            body: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) * 0.06,
                    vertical: 10,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: AutoSizeText(
                              "Welcome to the Crop Recommendation Form!",
                              style: kHeading22.copyWith(color: primaryColor2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: AutoSizeText(
                              "Our tool uses advanced algorithms to analyze various factors, including your city's location and climate, the pH level of your soil, and the levels of rainfall, nitrogen, phosphorus, and potassium in your field. Based on this information, we can recommend the best crops for you to grow in your specific environment",
                              style: kHeading16,
                              minFontSize: 1,
                              maxLines: 7,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AutoSizeText(
                              'Select the city from the dropdown below :',
                              style: kHeading14,
                              minFontSize: 1,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        CSCPicker(
                          layout: Layout.vertical,
                          countryDropdownLabel: "*Country",
                          stateDropdownLabel: "*State",
                          cityDropdownLabel: "*City",
                          disabledDropdownDecoration: BoxDecoration(
                            color: primaryColor6,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          currentCity: cityName,
                          flagState: CountryFlag.DISABLE,
                          currentCountry: countryName,
                          currentState: stateName,
                          dropdownDecoration: BoxDecoration(
                            color: primaryColor5,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          searchBarRadius: 16,
                          onCityChanged: (value) {
                            if (value != null) {
                              context
                                  .read<RecommendationBloc>()
                                  .add(CityChangeEvent(value));
                            }
                          },
                          onCountryChanged: (value) {
                            context
                                .read<RecommendationBloc>()
                                .add(CountryChangeEvent(value));
                          },
                          onStateChanged: (value) {
                            if (value != null) {
                              context
                                  .read<RecommendationBloc>()
                                  .add(StateChangeEvent(value));
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CustomAnimatedButton(
                            title: 'Next',
                            height: 46,
                            // backgroundColor: ,
                            borderRadius: 25,
                            width: displayWidth(context) * 0.5,
                            onPressed: () {
                              Future.delayed(const Duration(milliseconds: 600),
                                  () {
                                context.read<RecommendationBloc>().add(
                                      NextButtonClickedEvent(
                                        countryName,
                                        cityName,
                                        stateName,
                                      ),
                                    );
                              });
                            },
                          ),
                        ),
                        const RecommendationPageCarousal(),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: isError
                      ? InkWell(
                          onTap: () {
                            context.read<RecommendationBloc>().add(
                                  SubmitDataToBackendEvent(
                                    cityName: cityName!,
                                    countryName: countryName!,
                                    stateName: stateName!,
                                    rainfallLevel: _rainfallController.text,
                                    nitrgoenLevel: _nitrogenController.text,
                                    phLevel: _phLevelController.text,
                                    phosphorusLevel: _phosphorusController.text,
                                    potassiumLevel: _potassiumController.text,
                                  ),
                                );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: displayHeight(context) * 0.4,
                            ),
                            child: ErrorText(
                              error: error,
                              showRetry: true,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: displayWidth(context) * 0.1,
                            vertical: 18,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DefaultTextBox(
                                key: const ValueKey("phLevel"),
                                hintText: 'pH Level of Soil',
                                labelText: 'pH Level',
                                icon: const Icon(
                                  Icons.nature_rounded,
                                  color: primaryColor2,
                                ),
                                textEditingController: _phLevelController,
                                textInputType: TextInputType.number,
                                obscureText: false,
                                enabled: true,
                                backgroundColor: primaryColor5,
                              ),
                              DefaultTextBox(
                                key: const ValueKey("Rainfall"),
                                hintText: 'Rainfall',
                                labelText: 'Rainfall',
                                icon: const Icon(
                                  Icons.water_drop_rounded,
                                  color: primaryColor2,
                                ),
                                textEditingController: _rainfallController,
                                textInputType: TextInputType.number,
                                obscureText: false,
                                enabled: true,
                                backgroundColor: primaryColor5,
                              ),
                              DefaultTextBox(
                                key: const ValueKey("NitrogenLevel"),
                                hintText: 'Nitrogen Level',
                                labelText: 'Nitrogen Level',
                                icon: const Icon(
                                  Icons.gas_meter_rounded,
                                  color: primaryColor2,
                                ),
                                textEditingController: _nitrogenController,
                                textInputType: TextInputType.number,
                                obscureText: false,
                                enabled: true,
                                backgroundColor: primaryColor5,
                              ),
                              DefaultTextBox(
                                key: const ValueKey("Phosphorus Level"),
                                hintText: 'Phosphorus Level',
                                labelText: 'Phosphorus Level',
                                icon: const Icon(
                                  Icons.gas_meter_rounded,
                                  color: primaryColor2,
                                ),
                                textEditingController: _phosphorusController,
                                textInputType: TextInputType.number,
                                obscureText: false,
                                enabled: true,
                                backgroundColor: primaryColor5,
                              ),
                              DefaultTextBox(
                                focusNode: potassiumFocusNode,
                                key: const ValueKey("Potassium Level"),
                                hintText: 'Potassium Level',
                                labelText: 'Potassium Level',
                                icon: const Icon(
                                  Icons.gas_meter_rounded,
                                  color: primaryColor2,
                                ),
                                textEditingController: _potassiumController,
                                textInputType: TextInputType.number,
                                obscureText: false,
                                enabled: true,
                                backgroundColor: primaryColor5,
                              ),
                              isLoading
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: displayHeight(context) * 0.02,
                                      ),
                                      child: const LoadingIndicator(),
                                    )
                                  : showResult
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 14.0),
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
                                                    'Best Recommended Crop according to these conditions is : ${crop!.predictedCrop}',
                                                    speed: const Duration(
                                                      milliseconds: 70,
                                                    ),
                                                    textStyle:
                                                        kHeading18.copyWith(
                                                      color: primaryColor1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: CustomAnimatedButton(
                                            title: 'Submit',
                                            height: 46,
                                            borderRadius: 25,
                                            width: displayWidth(context) * 0.5,
                                            onPressed: () {
                                              Future.delayed(
                                                const Duration(
                                                    milliseconds: 600),
                                                () {
                                                  context
                                                      .read<
                                                          RecommendationBloc>()
                                                      .add(
                                                        SubmitRecommendationFormClickedEvent(
                                                          rainfallLevel:
                                                              _rainfallController
                                                                  .text,
                                                          nitrgoenLevel:
                                                              _nitrogenController
                                                                  .text,
                                                          phLevel:
                                                              _phLevelController
                                                                  .text,
                                                          phosphorusLevel:
                                                              _phosphorusController
                                                                  .text,
                                                          potassiumLevel:
                                                              _potassiumController
                                                                  .text,
                                                        ),
                                                      );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
