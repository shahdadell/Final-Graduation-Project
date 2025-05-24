import 'package:graduation_project/auth/data/model/response/LogOut/LogOutResponse.dart';
import 'package:graduation_project/auth/data/model/response/Login/LoginResponse.dart';
import 'package:graduation_project/auth/data/model/response/OTP/CheckEmailResponse.dart';
import 'package:graduation_project/auth/data/model/response/Register/registerresponse_new.dart';
import 'package:graduation_project/auth/data/model/response/Register/VerfiyCodeResponse.dart';
import 'package:graduation_project/auth/data/model/response/ResendCode.dart';
import 'package:graduation_project/auth/data/model/response/ResetPassword/ResetPasswordResponse.dart';
import 'package:graduation_project/auth/data/model/response/ResetPassword/VerfiyCodeForgetPasswordResponse.dart';
import 'package:graduation_project/auth/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';

class AuthRepositoryImpl implements AuthRepositoryContract {
  AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<RegisterresponseNew> register(
      String username, String password, String email, String phone) {
    return remoteDataSource.register(username, password, email, phone);
  }

  @override
  Future<LoginResponse> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<CheckEmailResponse> checkemail(String email) {
    return remoteDataSource.checkemail(email);
  }

  @override
  Future<VerfiyCodeResponse> verifyCode(String email, String verifyCode) {
    return remoteDataSource.verifyCode(email, verifyCode);
  }

  @override
  Future<VerfiyCodeForgetPasswordResponse> verifyCodeForgetPassword(
      String email, String verifyCode) {
    return remoteDataSource.verifyCodeForgetPassword(email, verifyCode);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      String email, String hashedPassword) async {
    return await remoteDataSource.resetPassword(email, hashedPassword);
  }

  @override
  Future<ResendCodeResponse> resendCode(String email) async {
    return await remoteDataSource.resendCode(email);
  }

  @override
  Future<LogOutResponse> logout() {
    return remoteDataSource.logout();
  }
}
