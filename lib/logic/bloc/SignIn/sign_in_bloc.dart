import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zecruiters_rms/Routers/app_route_constants.dart';
import 'package:zecruiters_rms/core/constant/Dialog/Common_dialog.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';
import 'package:zecruiters_rms/core/constant/global.dart';
import 'package:zecruiters_rms/core/constant/loading.dart';
import 'package:zecruiters_rms/data/repositories/Auth.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    on<mobNoEvent>(mobNoEvents);
    on<otpEvent>(otpEvents);

    on<LoginEvent>(login);

  }

  Future<FutureOr<void>> login(
      LoginEvent event, Emitter<SignInState> emit) async {
    try {
      Loading().showloading(event.context);
      var result = await AuthRepo.login(param: {
        "mobNo": state.mobNo,
      });

      if (result.status == true) {
        Global.storageServices
            .setString(SecureSharedPreference.deviceToken, result.data.token);
        Loading().dismissloading(event.context);

        GoRouter.of(event.context)
            .pushNamed(MyAppRouteConstants.dashBoardScreen);
      } else {
        Loading().dismissloading(event.context);

        CommonDialog.errorMessage(result.message);
      }
    } catch (e) {
      Loading().dismissloading(event.context);
      CommonDialog.errorMessage(e.toString());
    }
  }

  FutureOr<void> mobNoEvents(mobNoEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(mobNo: event.mobNo));
  }

  FutureOr<void> otpEvents(otpEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(otp: event.otp));
  }


}
