import 'dart:io';

import 'package:crop_sense/domain/sensor_data/sensor_data_response.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:http_parser/http_parser.dart';

import 'package:crop_sense/domain/core/i_main_api_repository.dart';
import 'package:crop_sense/domain/recommendation/recommendation_response.dart';

import '../helper/error_handler.dart';

class MainApiRepository implements IMainApiRepository {
  final BaseOptions options = BaseOptions(
    receiveTimeout: 70000,
    connectTimeout: 70000,
    receiveDataWhenStatusError: true,
    contentType: "application/json",
    headers: {"accept-version": '1.0.0'},
  );

  @override
  Future<RecommendationResponse> getRecommededCrop({
    required int n,
    required int p,
    required int k,
    required double rainfall,
    required String city,
    required double ph,
  }) async {
    try {
      final response = await Dio(options).get(
        "https://minor-project-server.onrender.com/crop-predict",
        queryParameters: {
          "N": n,
          "P": p,
          "K": k,
          "ph": ph,
          "rainfall": rainfall,
          "city": city,
        },
      );
      return RecommendationResponse.fromJson(response.data);
    } on DioError catch (e) {
      Logger().e(e.toString());
      return ErrorHandler.handleError(e);
    }
  }

  @override
  Future predictPlantDisease({required File picture}) async {
    try {
      MultipartFile plantImage;
      String fileName;
      fileName = picture.path.split("/").last;

      plantImage = await MultipartFile.fromFile(
        picture.path,
        filename: fileName,
        contentType: MediaType('image', 'jpeg'),
      );

      Logger().i("Image also going with name: $fileName");
      final response = await Dio(options).post(
        "https://cropsense-disease-prediction.onrender.com/upload",
        data: FormData.fromMap({
          "image": plantImage,
        }),
      );
      Logger().i(response.data);
      return response.data;
    } on DioError catch (e) {
      Logger().e(e);
      return ErrorHandler.handleError(e);
    }
  }

  @override
  Future fetchSensorData() async {
    try {
      final response = await Dio(options).get(
        "https://cropsense-sensor.onrender.com/",
      );
      Logger().i(response.data);
      return SensorDataResponse.fromJson(response.data);
    } on DioError catch (e) {
      Logger().e(e.toString());
      return ErrorHandler.handleError(e);
    }
  }

  @override
  Future fetchSensorRecommendedCrop() async {
    try {
      final response = await Dio(options).get(
        "https://minor-project-server.onrender.com/crop-predict-sensor",
      );
      Logger().i(response.data);
      return RecommendationResponse.fromJson(response.data);
    } on DioError catch (e) {
      Logger().e(e.toString());
      return ErrorHandler.handleError(e);
    }
  }
}
