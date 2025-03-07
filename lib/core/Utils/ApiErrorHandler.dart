import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:zecruiters_rms/core/Utils/Context_Utility.dart';

import '../../Routers/app_route_constants.dart';
import '../constant/SecureSharedPref.dart';
import '../constant/global.dart';

class ApiErrorHandler {
  static String handleDioError(DioException e) {
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 400:
          return "Bad request. Please check your input!";
        case 401:
          Global.storageServices.remove(SecureSharedPreference.deviceToken);
          GoRouter.of(ContextUtility.context!)
              .goNamed(MyAppRouteConstants.loginScreen);
          return "Unauthorized. Please log in again!";
        case 403:
          return "Forbidden. You do not have permission!";
        case 404:
          return "Resource not found!";
        case 422:
          return "Invalid data provided. Please review your input!";
        case 500:
          return "Internal server error. Please try again later!";
        default:
          return "Unexpected error occurred (Status code: ${e.response!.statusCode}). Please try again.";
      }
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return "The request timed out. Please check your network connection and try again.";
        case DioExceptionType.connectionError:
          return "There was a network issue. Please check your internet connection and try again.";
        case DioExceptionType.unknown:
          return "An unknown error occurred. Please try again or contact support.";
        default:
          return "An unexpected error occurred. Please try again.";
      }
    }
  }
}
