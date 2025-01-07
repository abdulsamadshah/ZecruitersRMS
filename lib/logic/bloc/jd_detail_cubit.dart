import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';
import 'package:zecruiters_rms/core/constant/global.dart';
import 'package:zecruiters_rms/data/models/JDListResponse.dart';
import 'package:zecruiters_rms/data/models/JobDetailResponse.dart';
import 'package:zecruiters_rms/data/repositories/JdDetail_Repo.dart';

part 'jd_detail_state.dart';

class JdDetailCubit extends Cubit<JdDetailState> {
  JdDetailCubit() : super(JdDetailInitial());

  Future<void> getJDListData() async {
    try {
      emit(LoadingState());
      var result = await JdDetail_Repo.getJD_Detail();
      if (result.status == true) {
        emit(JdDetailLoadingSuccess(listData: result.data));
      } else {
        emit(LoadingError(result.response.toString()));
      }
    } catch (e) {
      emit(LoadingError(e.toString()));
    }
  }

  Future<void> getJDDetailData({required String jdid}) async {
    try {
      emit(LoadingState());
      var data = {
        'companyid': Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().userId.toString(),
        'access_rights': Global.storageServices.getProfileData().accessRights.toString(),
        'jdid': jdid
      };
      var result = await JdDetail_Repo.getJobDetail(param: data);
      if (result.status == true) {
        emit(JobDetailLoadingSuccess(detail: result.data?[0]));
      } else {
        emit(LoadingError(result.response.toString()));
      }
    } catch (e) {
      emit(LoadingError(e.toString()));
    }
  }
}
