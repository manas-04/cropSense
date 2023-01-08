import 'package:crop_sense/domain/core/i_main_api_repository.dart';
import 'package:crop_sense/domain/recommendation/recommendation_response.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../helper/error_handler.dart';

class MainApiRepository implements IMainApiRepository {
  final BaseOptions options = BaseOptions(
    receiveTimeout: 20000,
    connectTimeout: 20000,
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
}
