import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/data/model/response/LogOut/LogOutResponse.dart';
import 'package:graduation_project/auth/data/model/response/OTP/CheckEmailResponse.dart';
import 'package:graduation_project/auth/data/model/response/Login/LoginResponse.dart';
import 'package:graduation_project/auth/data/model/response/Register/registerresponse_new.dart';
import 'package:graduation_project/auth/data/model/response/Register/VerfiyCodeResponse.dart';
import 'package:graduation_project/auth/data/model/response/ResendCode.dart';
import 'package:graduation_project/auth/data/model/response/ResetPassword/ResetPasswordResponse.dart';
import 'package:graduation_project/auth/data/model/response/ResetPassword/VerfiyCodeForgetPasswordResponse.dart';
import 'package:graduation_project/auth/domain/repository/data_source/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiManager apiManager;

  AuthRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<RegisterresponseNew> register(
      String username, String password, String email, String phone) async {
    return await apiManager.register(username, password, email, phone);
  }

  @override
  Future<LoginResponse> login(String email, String password) async {
    return await apiManager.login(email, password);
  }

  @override
  Future<CheckEmailResponse> checkemail(String email) async {
    return await apiManager.checkemail(email);
  }

  @override
  Future<VerfiyCodeResponse> verifyCode(String email, String verifyCode) async {
    return await apiManager.verifyCode(email, verifyCode);
  }

  @override
  Future<VerfiyCodeForgetPasswordResponse> verifyCodeForgetPassword(
      String email, String verifycode) async {
    return await apiManager.verifyCodeForgetPassword(email, verifycode);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      String email, String password) async {
    return await apiManager.resetPassword(email, password);
  }

  @override
  Future<ResendCodeResponse> resendCode(String email) async {
    return await apiManager.resendCode(email);
  }

  @override
  Future<LogOutResponse> logout() async {
    return await apiManager.logout();
  }
}
