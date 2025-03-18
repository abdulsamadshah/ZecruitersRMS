
import 'package:dio/dio.dart';
import 'package:zecruiters_rms/data/http/http_util.dart';
import 'package:zecruiters_rms/data/models/CallDetailRes.dart';
import 'package:zecruiters_rms/data/models/CallRecordStoreRes.dart';
import 'package:zecruiters_rms/data/models/CandiDateDetailRes.dart';
import 'package:zecruiters_rms/data/models/CandiDateListRes.dart';
import 'package:zecruiters_rms/data/models/CommonPostRes.dart';
import 'package:zecruiters_rms/data/models/RemakListRes.dart';

class CandiDate_Repo{
  static Future<CandiDateListRes> getCandidateList(var data) async {
    var response = await HttpUtil().post("/Zecapis/candidatelist",data: data);
    return CandiDateListRes.fromJson(response);
  }

  static Future<CandiDateDetailRes> getCandiDateDetail({required var param}) async {
    var response = await HttpUtil().post("/Zecapis/singlecandidate",data: param);
    return CandiDateDetailRes.fromJson(response);
  }

  static Future<CallDetailRes> getCallDataList(var data) async {
    var response = await HttpUtil().post("/Zecapis/calldata",data: data);
    return CallDetailRes.fromJson(response);
  }

  static Future<RemakListRes> getRemarkData(var data) async {
    var response = await HttpUtil().post("/Zecapis/remarkslist",data: data);
    return RemakListRes.fromJson(response);
  }

  static Future<CommonPostRes> postRemarkData(var data) async {
    var response = await HttpUtil().post("/Zecapis/formdatastore",data: data);
    return CommonPostRes.fromJson(response);
  }

  static Future<CallRecordStoreRes> postCallRecordStore(FormData data) async {
    var response = await HttpUtil().post("/Zecapis/callrecordstore",formdata: data,type: "formdata");
    return CallRecordStoreRes.fromJson(response);
  }

}