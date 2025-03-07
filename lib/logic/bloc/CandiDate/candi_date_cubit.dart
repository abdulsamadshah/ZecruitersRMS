import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';
import 'package:zecruiters_rms/core/constant/global.dart';
import 'package:zecruiters_rms/data/models/CallDetailRes.dart';
import 'package:zecruiters_rms/data/models/CandiDateDetailRes.dart';
import 'package:zecruiters_rms/data/models/CandiDateListRes.dart';
import 'package:zecruiters_rms/data/models/RemakListRes.dart';
import 'package:zecruiters_rms/data/repositories/CandiDate_Repo.dart';

import '../../../core/constant/Dialog.dart';
import '../../../core/constant/Utils.dart';
import '../../../core/constant/loading.dart';

part 'candi_date_state.dart';

class CandiDateCubit extends Cubit<CandiDateState> {
  CandiDateCubit() : super(CandiDateInitial());
  final comments = TextEditingController();
  final GlobalKey<FormState> remarkKey = GlobalKey<FormState>();

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
                  cubit: cubit,RemarkCallBack: RemarkCallBack);
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
      required CandiDateCubit cubit,void Function(bool)? RemarkCallBack}) async {
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
}
