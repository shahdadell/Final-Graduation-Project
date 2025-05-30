import 'package:graduation_project/auth/data/model/response/ResetPassword/VerfiyCodeForgetPasswordResponse.dart';

abstract class OtpForgetPasswordState {}

class OtpForgetPasswordInitialState extends OtpForgetPasswordState {}

class OtpForgetPasswordLoadingState extends OtpForgetPasswordState {}

class OtpForgetPasswordSuccessState extends OtpForgetPasswordState {
  final VerfiyCodeForgetPasswordResponse response;
  OtpForgetPasswordSuccessState({required this.response});
}

class OtpForgetPasswordErrorState extends OtpForgetPasswordState {
  final String? errorMessage;
  OtpForgetPasswordErrorState({this.errorMessage});
}

class OtpForgetPasswordResendTimerState extends OtpForgetPasswordState {
  final int countdown;
  OtpForgetPasswordResendTimerState(this.countdown);
}

class OtpForgetPasswordResendSuccessState extends OtpForgetPasswordState {}
