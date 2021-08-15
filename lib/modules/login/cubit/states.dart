import 'package:shop_app/models/login_model.dart';

abstract class LoginStates {}

class ChangeRememberMeCheckBoxState extends LoginStates {}

class ChangePasswordState extends LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}
