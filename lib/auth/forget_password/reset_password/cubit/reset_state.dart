import 'package:graduation_project/auth/data/model/response/ResetPassword/ResetPasswordResponse.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {
  String? loadingMessage;
  ResetPasswordLoadingState({this.loadingMessage});
}

class ResetPasswordSuccessState extends ResetPasswordState {
  ResetPasswordResponse response;
  ResetPasswordSuccessState({required this.response});
}

class ResetPasswordErrorState extends ResetPasswordState {
  String? errorMessage;
  ResetPasswordErrorState({this.errorMessage});
}
