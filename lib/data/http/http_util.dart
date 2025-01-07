
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zecruiters_rms/core/Utils/ApiErrorHandler.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';

import '../../core/constant/global.dart';

import 'Constant.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }
  Constant api = Constant();

  HttpUtil._internal() {
    api.sendRequest.interceptors.add(PrettyDioLogger());
  }

  Future<dynamic> post(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameteres,
        FormData? formdata,
        String? type}) async {
    try {
      api.sendRequest.options.headers['accept'] = 'application/json';
      api.sendRequest.options.headers["authorization"] = "${Global.storageServices.get(SecureSharedPreference.deviceToken)}";

      api.sendRequest.options.headers['content-type'] = 'application/json';
      api.sendRequest.options.headers['content-type'] = 'application/x-www-form-urlencoded';
      var response = await api.sendRequest.post(path,
          data: type == "formdata" ? formdata : data,
          queryParameters: queryParameteres);

      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiErrorHandler.handleDioError(e);
      } else {
        throw "An unexpected error occurred. Please try again.";
      }
    }
  }

  Future<dynamic> authPost(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameteres,
        FormData? formdata,
        String? type}) async {
    try {
      api.sendRequest.options.headers["authorization"] = "Bearer ${Global.storageServices.get(SecureSharedPreference.deviceToken)}";
      api.sendRequest.options.headers['accept'] = 'application/json';
      api.sendRequest.options.headers['content-type'] = 'application/json';
      var response = await api.sendRequest.post(path,
          data: type == "formdata" ? formdata : data,
          queryParameters: queryParameteres);

      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiErrorHandler.handleDioError(e);
      } else {
        throw "An unexpected error occurred. Please try again.";
      }
    }
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? data, String? LogOuttype}) async {
    try {
      api.sendRequest.options.headers["authorization"] = "${Global.storageServices.get(SecureSharedPreference.deviceToken)}";
      api.sendRequest.options.headers['accept'] = 'application/json';
      api.sendRequest.options.headers['content-type'] = 'application/json';
      var response = await api.sendRequest.get(path, queryParameters: data);
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw ApiErrorHandler.handleDioError(e);
      } else {
        throw "An unexpected error occurred. Please try again.";
      }
    }
  }
}

