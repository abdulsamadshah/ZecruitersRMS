
import 'package:dio/dio.dart';
import 'package:zecruiters_rms/data/http/http_util.dart';
import 'package:zecruiters_rms/data/models/CommonPostRes.dart';
import 'package:zecruiters_rms/data/models/ProfileData.dart';

import '../models/PersonalDetail_Res.dart';

class AuthRepo {
  static login({dynamic param}) async {
    var response = await HttpUtil().post("/User/auth/login", data: param);
    return PersonalDetail_Res.fromJson(response);
  }

  static personalDetail({FormData? param}) async {
    var response = await HttpUtil()
        .post("/User/auth/PersonalDetails", type: "formdata", formdata: param);
    return PersonalDetail_Res.fromJson(response);
  }

  static Future<ProfileDataRes> getProfile() async {
    var response = await HttpUtil().get("/User/auth/UserProfile");
    return ProfileDataRes.fromJson(response);
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
