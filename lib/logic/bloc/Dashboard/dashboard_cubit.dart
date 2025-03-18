import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zecruiters_rms/data/models/DashboardData.dart';
import 'package:zecruiters_rms/data/repositories/DashboardRepo.dart';

import '../../../core/constant/SecureSharedPref.dart';
import '../../../core/constant/Utils.dart';
import '../../../core/constant/global.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());

  void changeIndex(index) {
    emit(state.copyWith(selectedIndex: index));
  }

  //  selectedDate(date) {
  //   print("----------SelectedDateis:${date}");
  //   emit(state.copyWith(selectedDate: date));
  // }

  Future<void> getDashBoardData({DateTime? selectedDate}) async {
    try {
      emit(LoadingState());

      var data = {
        'companyid':
            Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().loingId.toString(),
        'access_rights':
            Global.storageServices.getProfileData().accessRights.toString(),
        'date': DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(selectedDate.toString())),
      };

      var result = await DashBoardRepo.getDashboardData(param: data);
      if (result.status == true) {
        emit(DashboardLoadingSuccess(detail: result.data));
      } else {
        Utils.fluttertoast(result.response.toString());
        // emit(LoadingError(result.response.toString()));
      }
    } catch (e) {
      Utils.fluttertoast(e.toString());
    }
  }
}
