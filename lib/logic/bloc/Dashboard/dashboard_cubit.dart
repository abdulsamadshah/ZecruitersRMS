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

  void selectedDate(date) {
    emit(state.copyWith(selectedDate: date));
  }

  Future<void> getDashBoardData({DateTime? selectedDate}) async {
    try {
      emit(LoadingState());
      var data = {
        'companyid':
            Global.storageServices.get(SecureSharedPreference.companyId),
        'userid': Global.storageServices.getProfileData().loingId.toString(),
        'access_rights':
            Global.storageServices.getProfileData().accessRights.toString(),
        'date': DateFormat('yyyy-MM-dd').format(selectedDate ?? state.selectedDate),

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

  Future<void> pickDate(BuildContext context,
      {required DashboardCubit cubit}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      cubit.selectedDate(pickedDate);
      cubit.getDashBoardData(selectedDate: pickedDate);
    }
  }
}
