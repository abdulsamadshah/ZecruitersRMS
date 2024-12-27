import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  FutureOr<void> login(LoginEvent event, Emitter<SignInState> emit) {}
}
