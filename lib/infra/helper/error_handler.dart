import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ErrorHandler {
  static handleError(DioError e) {
    var error = json.decode(e.response.toString());
    String message = "Something went wrong!";
    Logger().e(e.response?.data["error"]['message']);
    try {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          if (e.response?.data["error"]['message'] != "Token not Found") {
            message = "You don't have the permission to perform this action";
          } else {
            message = e.response?.data["error"]['message'];
          }
        } else if (e.response?.statusCode == 500) {
          message = e.response?.data["error"]['message'];
        } else if (e.response?.statusCode == 404) {
          message = e.response?.data["error"]['message'];
        } else if (e.response?.statusCode == 400) {
          if (e.response?.data["error"]['message'] ==
              'Refresh Token not Valid') {
            message =
                "Oops! Something went wrong. Please try again after restarting the app";
          } else {
            message = e.response?.data["error"]['message'];
          }
        } else if (e.response?.statusCode == 409) {
          message = e.response?.data["error"]['message'];
        } else if (e.response?.statusCode == 406) {
          message = e.response?.data["error"]['message'];
        } else if (e.response?.statusCode == 403) {
          message = e.response?.data["error"]['message'];
        }
      } else {
        message = error["error"]["message"];
      }
    } catch (e) {
      message = "Something went wrong!";
    }
    Logger().e(message);
    throw message;
  }
}
