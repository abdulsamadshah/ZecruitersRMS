
import 'package:dio/dio.dart';
import 'package:zecruiters_rms/data/http/http_util.dart';
import 'package:zecruiters_rms/data/models/CommonPostRes.dart';

import '../models/PersonalDetail_Res.dart';

class AuthRepo {
  static Future<LoginRes> login({dynamic param}) async {
    var response = await HttpUtil().post("/Zecapis/login", data: param);
    return LoginRes.fromJson(response);
  }




  static logOut({FormData? param}) async {
    var response = await HttpUtil().authPost("/logout");
    return CommonPostRes.fromJson(response);
  }

  static ResendOtp({dynamic param}) async {
    var response = await HttpUtil().post("/resend-otp", data: param);
    return CommonPostRes.fromJson(response);
  }
}
