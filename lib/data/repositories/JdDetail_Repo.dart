
import 'package:zecruiters_rms/data/http/http_util.dart';
import 'package:zecruiters_rms/data/models/JobDetailResponse.dart';
import 'package:zecruiters_rms/data/models/JDListResponse.dart';

class JdDetail_Repo{

  static Future<JDResponse> getJD_Detail() async {
    var response = await HttpUtil().post("/Zecapis/jdlist");
    return JDResponse.fromJson(response);
  }

  static Future<JDDetailResponse> getJobDetail({required var param}) async {
    var response = await HttpUtil().post("/Zecapis/jddetails",data: param);
    return JDDetailResponse.fromJson(response);
  }

}