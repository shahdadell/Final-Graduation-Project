import 'package:graduation_project/auth/data/model/response/OTP/CheckEmailResponse.dart';
import 'package:graduation_project/auth/data/model/response/ResetPassword/ResetPasswordResponse.dart';

abstract class CheckEmailState {}

class CheckEmailInitialState extends CheckEmailState {}

class CheckEmailLoadingState extends CheckEmailState {
  String? checkEmailMassage;
  CheckEmailLoadingState({this.checkEmailMassage});
}

class CheckEmailSuccessState extends CheckEmailState {
  CheckEmailResponse checkEmailResponse;
  CheckEmailSuccessState({required this.checkEmailResponse});
}

class CheckEmailErrorState extends CheckEmailState {
  String? checkEmailErrorMessage;
  CheckEmailErrorState({this.checkEmailErrorMessage});
}
