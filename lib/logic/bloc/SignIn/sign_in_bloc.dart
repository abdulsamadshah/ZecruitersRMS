import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zecruiters_rms/Routers/app_route_constants.dart';
import 'package:zecruiters_rms/core/constant/Dialog/Common_dialog.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';
import 'package:zecruiters_rms/core/constant/global.dart';
import 'package:zecruiters_rms/core/constant/loading.dart';
import 'package:zecruiters_rms/data/Services/Pref_Services.dart';
import 'package:zecruiters_rms/data/repositories/Auth.dart';
import 'package:zecruiters_rms/presentation/screen/Dashboard/Dashboard.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    on<companyIdEvent>(companyId);
    on<emailIdEvent>(emailId);
    on<passwordEvent>(password);
    on<LoginEvent>(login);

  }

  FutureOr<void> companyId(companyIdEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(companyId: event.companyId));
  }

  FutureOr<void> emailId(emailIdEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(emailId: event.emailId));
  }

  FutureOr<void> password(passwordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> login(LoginEvent event, Emitter<SignInState> emit) async {
    try {
      Loading().showloading(event.context);
      var result = await AuthRepo.login(
          param: {
            // "companyid": state.companyId,
            // "email": state.emailId,
            // "password": state.password,
            "companyid": "PAPERPINK",
            "email": "krutika@zecruiters.com",
            "password": 'Krutika@123',
          });

      if (result.status == true) {
        Global.storageServices
            .setString(SecureSharedPreference.deviceToken, result.token.toString());
        Loading().dismissloading(event.context);
        Pref_Services().saveProfileData(result.data);
        Global.storageServices.setString(SecureSharedPreference.companyId,"PAPERPINK");
        // Global.storageServices.setString(SecureSharedPreference.companyId,state.companyId);
        GoRouter.of(event.context)
            .pushNamed(MyAppRouteConstants.dashBoardScreen);
      }else if (result.status == false) {
        Loading().dismissloading(event.context);

        CommonDialog.errorMessage(result.response);
      }
    } catch (e) {
      Loading().dismissloading(event.context);
      CommonDialog.errorMessage(e.toString());
    }
  }
}
