import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';
import 'package:zecruiters_rms/core/constant/global.dart';
import 'package:zecruiters_rms/data/Services/CallHelper.dart';
import 'package:zecruiters_rms/data/models/CallDetailRes.dart';
import 'package:zecruiters_rms/data/models/CandiDateDetailRes.dart';
import 'package:zecruiters_rms/data/models/CandiDateListRes.dart';
import 'package:zecruiters_rms/data/models/RemakListRes.dart';
import 'package:zecruiters_rms/data/repositories/CandiDate_Repo.dart';
import 'package:http_parser/http_parser.dart';
import '../../../core/constant/Dialog.dart';
import '../../../core/constant/Utils.dart';
import '../../../core/constant/loading.dart';

part 'candi_date_state.dart';

class CandiDateCubit extends Cubit<CandiDateState> {
  CandiDateCubit() : super(CandiDateInitial());
  final comments = TextEditingController();
  final GlobalKey<FormState> remarkKey = GlobalKey<FormState>();


  bool isPriceLowToHigh = true;
  bool isAZSorted = false;
  List<CandiDateData> canDiDateModel = [];
  List<CandiDateData> allcanDiDate = [];
  List<CandiDateData> filteredCandiDate = [];

  callStartTime(callStartTime){
    emit(state.copyWith(call_start_time: callStartTime));
  }

  callEndTime(callEndTime){
    emit(state.copyWith(call_end_time: callEndTime));
  }

  callDuration(call_duration){
    emit(state.copyWith(call_duration: call_duration));
  }

  void searchCandiDate(String query) {
    query = query.trim();
    if (allcanDiDate.isEmpty) {
      return;
    }

    if (query.isEmpty) {
      canDiDateModel = allcanDiDate;
    } else {
      canDiDateModel = allcanDiDate.where((product) {
        final productNameMatch =
            product.jdId?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final productSizeMatch =
            product.firstName?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final productThicknessMatch = product.contactNo
            ?.toLowerCase()
            .contains(query.toLowerCase()) ??
            false;
        return productNameMatch || productSizeMatch || productThicknessMatch;
      }).toList();
    }

    emit(CandiDateLoadingSuccess(listData: canDiDateModel));
    // emit(ProductLoaded(productModel: productModel, filterCount: filterCount));
  }


  void sortProductsAlphabetically(bool isAscending) {
    filteredCandiDate = List.from(allcanDiDate);

    if (isAscending) {
      filteredCandiDate.sort((a, b) => a.firstName!.compareTo(b.firstName!));
    } else {
      filteredCandiDate.sort((a, b) => b.firstName!.compareTo(a.firstName!));
    }

    isAZSorted = isAscending;
    emit(CandiDateLoadingSuccess(listData: filteredCandiDate));

  }

  void resetFilters() {
    filteredCandiDate = List.from(allcanDiDate);
    isPriceLowToHigh = true;
    isAZSorted = false;
    emit(CandiDateLoadingSuccess(listData: allcanDiDate));
  }

  Future<void> getCandidateData(
      {required String jdId, required int listType}) async {
    try {
      emit(LoadingState());
      var data = {
        'companyid':
            Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().loingId.toString(),
        'access_rights':
            Global.storageServices.getProfileData().accessRights.toString(),
        'jdid': jdId,
        'listtype': listType,
      };
      var result = await CandiDate_Repo.getCandidateList(data);
      if (result.status == true) {
        canDiDateModel = result.data!;
        allcanDiDate = result.data!;
        emit(CandiDateLoadingSuccess(listData: result.data));
      } else {
        emit(LoadingError(result.response.toString()));
      }
    } catch (e) {
      emit(LoadingError(e.toString()));
    }
  }

  Future<void> getCandidateDetailData(
      {required String jdid,
      candidateid,
      required CandiDateCubit remarkList}) async {
    try {
      emit(LoadingState());
      var data = {
        'companyid':
            Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().loingId.toString(),
        'access_rights':
            Global.storageServices.getProfileData().accessRights.toString(),
        'jdid': jdid,
        'candidateid': candidateid
      };
      var result = await CandiDate_Repo.getCandiDateDetail(param: data);
      if (result.status == true) {
        emit(CandiDateDetailLoadingSuccess(detail: result.data?[0]));
        remarkList.SelectedRemarks({
          'id': result.data?[0].remarkstid.toString(),
          'remarks': result.data?[0].remarkst.toString()
        });
        remarkList.comments.text = result.data![0].remarks!.toString();
      } else {
        emit(LoadingError(result.response.toString()));
      }
    } catch (e) {
      emit(LoadingError(e.toString()));
    }
  }

  Future<void> getCallDataList(
      {required String jdId, required String mobNo}) async {
    try {
      emit(LoadingState());
      var data = {
        // 'companyid':
        //     Global.storageServices.get(SecureSharedPreference.companyId),
        // 'userid': "REC-63",
        // 'access_rights': "38,9,11,12,39,30,15",
        // 'jdid': "Z-2909",
        // 'mobilno': "9867497137",
        'companyid':
            Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().loingId.toString(),
        'access_rights':
            Global.storageServices.getProfileData().accessRights.toString(),
        'jdid': jdId,
        'mobilno': mobNo,
      };
      var result = await CandiDate_Repo.getCallDataList(data);
      if (result.status == true) {
        emit(CallDetailLoadingSuccess(callData: result.data));
      } else {
        emit(LoadingError(result.response.toString()));
      }
    } catch (e) {
      emit(LoadingError(e.toString()));
    }
  }

  Future<void> getReMarkList(
    BuildContext context, {
    required CandiDateCubit cubit,
    required String jdId,
    required String mobNo,
    candidateid,
    void Function(bool)? RemarkCallBack,
  }) async {
    try {
      Loading().showloading(context);
      var data = {
        'companyid':
            Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().loingId.toString(),
        'access_rights':
            Global.storageServices.getProfileData().accessRights.toString(),
      };
      var result = await CandiDate_Repo.getRemarkData(data);
      if (result.status == true) {
        Loading().dismissloading(context);
        emit(state.copyWith(remarkData: result.data));
        DialogBox.RemarkDialog(
          context,
          candiDateCubit: cubit,
          callBack: (status) {
            if (status) {
              Navigator.pop(context);
              SubmitReMarkList(context,
                  mobNo: mobNo,
                  jdId: jdId,
                  candidateid: candidateid,
                  cubit: cubit,
                  RemarkCallBack: RemarkCallBack);
            }
          },
        );
      } else {
        Loading().dismissloading(context);
        Utils.fluttertoast(result.response.toString());
      }
    } catch (e) {
      Loading().dismissloading(context);
      Utils.fluttertoast(e.toString());
    }
  }

  Future<void> SubmitReMarkList(BuildContext context,
      {required String jdId,
      required String mobNo,
      candidateid,
      required CandiDateCubit cubit,
      void Function(bool)? RemarkCallBack}) async {
    try {
      Loading().showloading(context);
      var data = {
        'companyid':
            Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().loingId.toString(),
        'access_rights':
            Global.storageServices.getProfileData().accessRights.toString(),
        'jdid': jdId,
        'mobilno': mobNo,
        'candidateid': candidateid,
        'remarks': cubit.state.SelectedremarkData['id'],
        'comments': cubit.comments.text,
      };
      var result = await CandiDate_Repo.postRemarkData(data);
      if (result.status == true) {
        Loading().dismissloading(context);
        Utils.fluttertoast("Remark Submit Successfully");
        RemarkCallBack!(true);
      } else {
        Loading().dismissloading(context);
        Utils.fluttertoast(result.message.toString());
      }
    } catch (e) {
      Loading().dismissloading(context);
      Utils.fluttertoast(e.toString());
    }
  }

  void SelectedRemarks(dynamic data) {
    emit(state.copyWith(SelectedremarkData: data));
  }

  Future<void> CallPostRecore(BuildContext context,
      {required String jdId,
      required String mobNo,
      candidateid,
      required CandiDateCubit cubit,
      void Function(bool)? RecordCallBack,
      // required dynamic callLog
      }) async {
    try {
      Loading().showloading(context);

      String filePath = await _getFilePath();
      FormData data = FormData.fromMap({
        'companyid':
            Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().loingId.toString(),
        'access_rights':
            Global.storageServices.getProfileData().accessRights.toString(),
        'jdid': jdId,
        'mobilno': mobNo,
        'candidateid': candidateid,
        'call_start_time': cubit.state.call_start_time,
        'call_end_time': cubit.state.call_end_time,
        'call_duration':cubit.state.call_duration,
      });

      data.files.add(MapEntry(
        'files',
        await MultipartFile.fromFile(
          filePath,
          filename: "call_recording.mp3",
          contentType: MediaType("audio", "mpeg"),
        ),
      ));

      var result = await CandiDate_Repo.postCallRecordStore(data);
      if (result.status == true) {
        Loading().dismissloading(context);
        Utils.fluttertoast("Submit Successfully");
        RecordCallBack!(true);
      } else {
        Loading().dismissloading(context);
        Utils.fluttertoast(result.response.toString());
      }
    } catch (e) {
      Loading().dismissloading(context);
      Utils.fluttertoast(e.toString());
    }
  }

  Future<String> _getFilePath() async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/dummy.mp3');

    if (!(await file.exists())) {
      await file.writeAsBytes(List.filled(1024, 0));
    }

    return file.path;
  }


  Future<void> makePhoneCall(String phone) async {

    var status = await Permission.phone.request();
    if (status.isGranted) {
      CallHelper.makeDirectCall("7387454586");
    } else {
      throw 'Phone call permission not granted';
    }


  }

  String formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}:"
        "${time.second.toString().padLeft(2, '0')}";
  }
  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }


}
