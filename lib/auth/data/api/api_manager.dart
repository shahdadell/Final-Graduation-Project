import 'dart:convert';
import 'package:graduation_project/auth/data/model/response/LogOut/LogOutResponse.dart';
import 'package:graduation_project/auth/data/model/response/RefreshToken/RefreshTokenResponse.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project/auth/data/model/request/Login/LoginRequest.dart';
import 'package:graduation_project/auth/data/model/request/ResetPasssword/OtpForgetPasswordRequest.dart';
import 'package:graduation_project/auth/data/model/request/Register/OtpRequest.dart';
import 'package:graduation_project/auth/data/model/response/OTP/CheckEmailResponse.dart';
import 'package:graduation_project/auth/data/model/response/Login/LoginResponse.dart';
import 'package:graduation_project/auth/data/model/response/Register/registerresponse_new.dart';
import 'package:graduation_project/auth/data/model/response/Register/VerfiyCodeResponse.dart';
import 'package:graduation_project/auth/data/model/response/ResetPassword/ResetPasswordResponse.dart';
import 'package:graduation_project/auth/data/model/response/ResetPassword/VerfiyCodeForgetPasswordResponse.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import '../model/request/ResetPasssword/CheckEmailRequest.dart';
import '../model/request/Register/RegisterRequest.dart';
import '../model/response/ResendCode.dart';
import 'api_constance.dart';

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;

  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  // Check internet connection (بديل بدون connectivity_plus)
  Future<bool> _checkInternetConnection() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Get headers with token
  Future<Map<String, String>> _getHeaders() async {
    String? token = await AppLocalStorage.getData('token');
    return {
      'Content-Type': 'application/x-www-form-urlencoded',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Refresh Token API Call
  Future<RefreshTokenResponse> refreshToken() async {
    try {
      String? refreshToken = await AppLocalStorage.getData('refresh_token');
      String? accessToken = await AppLocalStorage.getData('token');
      if (refreshToken == null || accessToken == null) {
        throw Exception('No refresh token or access token found.');
      }

      Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.refreshToken);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $accessToken',
        },
        body: {'refresh_token': refreshToken},
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var refreshResponse = RefreshTokenResponse.fromJson(data);
        if (refreshResponse.status == 'success' &&
            refreshResponse.accessToken != null) {
          await AppLocalStorage.cacheData('token', refreshResponse.accessToken);
          if (refreshResponse.expiresIn != null) {
            await AppLocalStorage.cacheData(
                'token_expiry',
                DateTime.now().millisecondsSinceEpoch +
                    (refreshResponse.expiresIn! * 1000));
          }
          return refreshResponse;
        } else {
          throw Exception('Failed to refresh token.');
        }
      } else {
        throw Exception('Failed to refresh token: ${response.statusCode}');
      }
    } catch (e) {
      print('Refresh token error: $e');
      throw Exception('Failed to refresh token: $e');
    }
  }

  // Logout API Call
  Future<LogOutResponse> logout() async {
    try {
      String? refreshToken = await AppLocalStorage.getData('refresh_token');
      String? accessToken = await AppLocalStorage.getData('token');
      if (refreshToken == null || accessToken == null) {
        throw Exception('No refresh token or access token found.');
      }

      Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.logout);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $accessToken',
        },
        body: {'refresh_token': refreshToken},
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LogOutResponse.fromJson(data);
      } else {
        throw Exception('Failed to logout: ${response.statusCode}');
      }
    } catch (e) {
      print('Logout error: $e');
      throw Exception('Failed to logout: $e');
    }
  }

  // Generic method for POST requests with token refresh
  Future<http.Response> _postWithTokenRefresh(
      Uri url, Map<String, dynamic> body) async {
    if (!(await _checkInternetConnection())) {
      throw Exception('No internet connection. Please check your network.');
    }

    var headers = await _getHeaders();
    var response = await http
        .post(url, headers: headers, body: body)
        .timeout(Duration(seconds: 10));

    print('Request URL: $url');
    print('Request Headers: $headers');
    print('Request Body: $body');
    print('Response Status Code: ${response.statusCode}');
    print('Response Headers: ${response.headers}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 401) {
      var refreshResponse = await refreshToken();
      if (refreshResponse.status == 'success') {
        headers = await _getHeaders();
        response = await http
            .post(url, headers: headers, body: body)
            .timeout(Duration(seconds: 10));
      } else {
        throw Exception('Session expired. Please log in again.');
      }
    }

    return response;
  }

  // Resend Code API Call
  Future<ResendCodeResponse> resendCode(String email) async {
    Uri url = Uri.https(ApiConstants.baseUrl, '/outbye/auth/resend.php');
    try {
      var response = await _postWithTokenRefresh(url, {'email': email});
      return ResendCodeResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('Resend code error: $e');
      throw Exception('Failed to resend code: $e');
    }
  }

  Future<RegisterresponseNew> register(
      String username, String password, String email, String phone) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.registerApi);
    var requestBody = RegisterRequest(
      username: username,
      email: email,
      password: password,
      phone: phone,
    );

    try {
      var response = await _postWithTokenRefresh(url, requestBody.toJson());
      if (response.statusCode == 200) {
        String contentType = response.headers['content-type'] ?? '';
        if (!contentType.contains('application/json')) {
          throw Exception(
              'Invalid response format: Expected JSON, got $contentType');
        }
        var registerResponse =
            RegisterresponseNew.fromJson(jsonDecode(response.body));
        if (registerResponse.token != null) {
          await AppLocalStorage.cacheData('token', registerResponse.token);
          if (registerResponse.token != null) {
            await AppLocalStorage.cacheData(
                'refresh_token', registerResponse.token);
          }
        }
        return registerResponse;
      } else {
        throw Exception('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      print('Register error: $e');
      throw Exception('Failed to register: $e');
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.LoginApi);
    var requestBody = LoginRequest(email: email, password: password);

    try {
      var response = await _postWithTokenRefresh(url, requestBody.toJson());

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to login: Server returned ${response.statusCode}');
      }

      String contentType = response.headers['content-type'] ?? '';
      if (!contentType.contains('application/json')) {
        throw Exception(
            'Invalid response format: Expected JSON, got $contentType');
      }

      var loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
      if (loginResponse.accessToken != null) {
        await AppLocalStorage.cacheData('token', loginResponse.accessToken);
        if (loginResponse.refreshToken != null) {
          await AppLocalStorage.cacheData(
              'refresh_token', loginResponse.refreshToken);
        }
      }
      return loginResponse;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to login: $e');
    }
  }

  Future<CheckEmailResponse> checkemail(String email) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.checkemail);
    var requestBody = CheckEmailRequest(email: email);

    try {
      var response = await _postWithTokenRefresh(url, requestBody.toJson());
      if (response.statusCode == 200) {
        String contentType = response.headers['content-type'] ?? '';
        if (!contentType.contains('application/json')) {
          throw Exception(
              'Invalid response format: Expected JSON, got $contentType');
        }
        return CheckEmailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to check email: ${response.statusCode}');
      }
    } catch (e) {
      print('Check email error: $e');
      throw Exception('Failed to check email: $e');
    }
  }

  Future<VerfiyCodeResponse> verifyCode(String email, String verifyCode) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.verifyCodeApi);
    var requestBody = OtpRequest(email: email, verifycode: verifyCode);

    try {
      var response = await _postWithTokenRefresh(url, requestBody.toJson());
      if (response.statusCode == 200) {
        String contentType = response.headers['content-type'] ?? '';
        if (!contentType.contains('application/json')) {
          throw Exception(
              'Invalid response format: Expected JSON, got $contentType');
        }
        return VerfiyCodeResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to verify code: ${response.statusCode}');
      }
    } catch (e) {
      print('Verify code error: $e');
      throw Exception('Failed to verify code: $e');
    }
  }

  Future<VerfiyCodeForgetPasswordResponse> verifyCodeForgetPassword(
      String email, String verifycode) async {
    Uri url =
        Uri.https(ApiConstants.baseUrl, ApiConstants.verifyCodeForgetPassword);
    var requestBody =
        OtpScreenForgetPassword(email: email, verifycode: verifycode);

    try {
      var response = await _postWithTokenRefresh(url, requestBody.toJson());
      if (response.statusCode == 200) {
        String contentType = response.headers['content-type'] ?? '';
        if (!contentType.contains('application/json')) {
          throw Exception(
              'Invalid response format: Expected JSON, got $contentType');
        }
        return VerfiyCodeForgetPasswordResponse.fromJson(
            jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to verify code for forget password: ${response.statusCode}');
      }
    } catch (e) {
      print('Verify code forget password error: $e');
      throw Exception('Failed to verify code for forget password: $e');
    }
  }

  Future<ResetPasswordResponse> resetPassword(
      String email, String password) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.resetpassword);

    if (email == null || email.isEmpty) {
      print("Error: Email is null or empty");
      return ResetPasswordResponse(status: "error");
    }
    if (password == null || password.isEmpty) {
      print("Error: Password is null or empty");
      return ResetPasswordResponse(status: "error");
    }

    try {
      var response = await _postWithTokenRefresh(url, {
        'email': email,
        'password': password,
      });

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      if (response.statusCode != 200) {
        return ResetPasswordResponse(status: "error");
      }

      String contentType = response.headers['content-type'] ?? '';
      if (!contentType.contains('application/json')) {
        return ResetPasswordResponse(status: "error");
      }

      var jsonResponse = jsonDecode(response.body);
      return ResetPasswordResponse.fromJson(jsonResponse);
    } catch (e) {
      print("Exception occurred: $e");
      return ResetPasswordResponse(status: "error");
    }
  }
}
