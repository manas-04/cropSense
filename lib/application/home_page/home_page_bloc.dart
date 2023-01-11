import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:crop_sense/application/helpers/event.dart';
import 'package:crop_sense/domain/sensor_data/sensor_data_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:logger/logger.dart';

import '../../infra/api_repository/main_api_respository.dart';

part 'home_page_state.dart';
part 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(HomePageState initstate) : super(initstate) {
    final MainApiRepository apiRepository = MainApiRepository();

    on<LetsExploreClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(LetsExploreClickedState());
    });
    on<ContributeToUsButtonClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(ContributeToUsButtonClickedState());
    });
    on<CropRecommendationFeatureClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(CropRecommendationFeatureClickedState());
    });
    on<PlantsIOTImageClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(PlantsIOTImageClickedState());
    });
    on<IPULogoClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(IPULogoClickedState());
    });
    on<DiseaseDetectionClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(DiseaseDetectionClickedState());
    });
    on<ChooseFileButtonClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(ChooseFileButtonClickedState());
    });
    on<FileSelectedEvent>((event, emit) async {
      final image = decodeImage(event.selectedImage.readAsBytesSync());

      if (image!.width > 224 || image.height > 224) {
        final resizedImage = copyResize(image, height: 224, width: 224);

        event.selectedImage.writeAsBytesSync(encodeJpg(resizedImage));
      }

      var decodedImage =
          await decodeImageFromList(event.selectedImage.readAsBytesSync());
      Logger().i("Dataaaaaa ${decodedImage.width}");
      Logger().i("Dataaaaaa ${decodedImage.height}");
      emit(FileSelectedState(event.selectedImage));
    });
    on<PredictClickedEvent>((event, emit) async {
      try {
        emit(PredictLoadingState());
        final response = await apiRepository.predictPlantDisease(
          picture: event.selectedImage,
        );
        emit(PredictionSuccessfulState(response["data"]));
      } catch (e) {
        emit(PredictionErrorState(e.toString()));
      }
    });
    on<TakeDataFromSensorClickedEvent>((event, emit) {
      emit(EmptyHomePageState());
      emit(TakeDataFromSensorClickedState());
    });
    on<FetchDataFromSensor>((event, emit) async {
      emit(DataFromSensorLoadingState());
      try {
        final SensorDataResponse response =
            await apiRepository.fetchSensorData();

        emit(DataFromSensorLoadedState(response));
      } catch (e) {
        emit(DataFromSensorErrorState(e.toString()));
      }
    });
  }
}
