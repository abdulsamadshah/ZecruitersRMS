part of 'sign_in_bloc.dart';

class SignInState {
  final String companyId;
  final String emailId;
  final String password;

  SignInState({this.companyId = "", this.password = "", this.emailId = ""});

  SignInState copyWith({
    String? companyId,
    String? emailId,
    String? password,
  }) {
    return SignInState(
        companyId: companyId ?? this.companyId,
        emailId: emailId ?? this.emailId,
        password: password ?? this.password);
  }
}
