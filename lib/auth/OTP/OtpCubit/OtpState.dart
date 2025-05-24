import 'package:graduation_project/auth/data/model/response/Register/VerfiyCodeResponse.dart';

abstract class OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpSuccessState extends OtpState {
  final VerfiyCodeResponse response;
  OtpSuccessState({required this.response});
}

class OtpErrorState extends OtpState {
  final String? errorMessage;
  OtpErrorState({this.errorMessage});
}

class OtpResendTimerState extends OtpState {
  final int countdown;
  OtpResendTimerState(this.countdown);
}

class OtpResendSuccessState extends OtpState {}
