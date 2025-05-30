import 'package:graduation_project/auth/data/model/response/LogOut/LogOutResponse.dart';
import 'package:graduation_project/auth/data/model/response/OTP/CheckEmailResponse.dart';
import 'package:graduation_project/auth/data/model/response/Login/LoginResponse.dart';
import 'package:graduation_project/auth/data/model/response/Register/registerresponse_new.dart';
import 'package:graduation_project/auth/data/model/response/Register/VerfiyCodeResponse.dart';
import 'package:graduation_project/auth/data/model/response/ResetPassword/ResetPasswordResponse.dart';
import 'package:graduation_project/auth/data/model/response/ResetPassword/VerfiyCodeForgetPasswordResponse.dart';
import '../../../data/model/response/ResendCode.dart';

abstract class AuthRepositoryContract {
  Future<RegisterresponseNew> register(
      String username, String password, String email, String phone);
  Future<LoginResponse> login(String email, String password);
  Future<CheckEmailResponse> checkemail(String email);
  Future<VerfiyCodeResponse> verifyCode(String email, String verifyCode);
  Future<VerfiyCodeForgetPasswordResponse> verifyCodeForgetPassword(
      String email, String verifycode);
  Future<ResetPasswordResponse> resetPassword(String email, String password);
  Future<ResendCodeResponse> resendCode(String email);
  Future<LogOutResponse> logout();
}
