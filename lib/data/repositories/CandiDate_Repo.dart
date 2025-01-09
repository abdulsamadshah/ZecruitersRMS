
import 'package:zecruiters_rms/data/http/http_util.dart';
import 'package:zecruiters_rms/data/models/CandiDateListRes.dart';

class CandiDate_Repo{
  static Future<CandiDateListRes> getCandidateList(var data) async {
    var response = await HttpUtil().post("/Zecapis/candidatelist",data: data);
    return CandiDateListRes.fromJson(response);
  }
}