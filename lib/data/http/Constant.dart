import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const Color primaryColor = Color(0xFF7B61FF);
const double defaultPadding = 16.0;
var BaseUrl = "https://www.rms.zecruiters.com/api";

var ImagenotFound =
    "https://thumbs.dreamstime.com/b/computer-logo-pc-logo-vector-computer-logo-pc-logo-vector-142583250.jpg";

class Constant {
  static String Baseurl = "$BaseUrl";

  static String imageBaseUrl = "https://www.rms.zecruiters.com/";
  static BaseOptions networkOptions = BaseOptions(
    receiveTimeout: const Duration(seconds: 15),
    connectTimeout: const Duration(seconds: 15),
    baseUrl: Baseurl,
  );
  final Dio _dio = Dio();
  Constant() {
    BaseOptions options = BaseOptions(
      baseUrl: Baseurl,
    );
    _dio.options = options;
    _dio.interceptors.add(PrettyDioLogger());
  }
  Dio get sendRequest => _dio;
}
