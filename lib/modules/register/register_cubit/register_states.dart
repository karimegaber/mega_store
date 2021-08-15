import 'package:shop_app/models/register_model.dart';

class RegisterStates {}

class InitialRegisterState extends RegisterStates {}

class ChangeRememberMeCheckBoxState extends RegisterStates {}

class ChangeRegisterPasswordState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates {}
