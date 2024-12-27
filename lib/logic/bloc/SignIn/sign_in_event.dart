part of 'sign_in_bloc.dart';


abstract class SignInEvent {
  SignInEvent();
}

class companyIdEvent extends SignInEvent{
  final String companyId;
  companyIdEvent(this.companyId);
}

class emailIdEvent extends SignInEvent{
  final String emailId;
  emailIdEvent(this.emailId);
}

class passwordEvent extends SignInEvent{
  final String password;
  passwordEvent(this.password);
}





class LoginEvent extends SignInEvent{
  BuildContext context;
  LoginEvent(this.context,);
}