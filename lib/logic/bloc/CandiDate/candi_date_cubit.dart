import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';
import 'package:zecruiters_rms/core/constant/global.dart';
import 'package:zecruiters_rms/data/models/CandiDateListRes.dart';
import 'package:zecruiters_rms/data/repositories/CandiDate_Repo.dart';

part 'candi_date_state.dart';

class CandiDateCubit extends Cubit<CandiDateState> {
  CandiDateCubit() : super(CandiDateInitial());


  Future<void> getCandidateData({required String jdId,required int listType}) async {
    try {
      emit(LoadingState());
      var data = {
        'companyid': Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().loingId.toString(),
        'access_rights': Global.storageServices.getProfileData().accessRights.toString(),
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
}
