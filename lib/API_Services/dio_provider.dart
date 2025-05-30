// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/API_Services/endpoints.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'package:graduation_project/main.dart';

class DioProvider {
  static late Dio _dio;
  static bool _isRedirecting = false;

  static Future<void> init() async {
    await AppLocalStorage.init();
    _dio = Dio(BaseOptions(
      baseUrl: AppEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (status) {
        return status! >= 200 && status < 300;
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request [${options.method}] to: ${options.uri}');
        print('Headers: ${options.headers}');
        print('Data: ${options.data}');
        print('Query Parameters: ${options.queryParameters}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print(
            'Response [${response.statusCode}] from: ${response.requestOptions.uri}');
        print('Response Headers: ${response.headers}');
        print('Raw Response: ${response.data}');

        if (response.data == null || response.data.toString().trim().isEmpty) {
          print('Error: Response is empty or null');
          throw Exception('Response is empty or null');
        }

        String responseData = response.data.toString().trim();
        print('Trimmed Response: $responseData');

        try {
          response.data = jsonDecode(responseData);
          print('Cleaned Response (Parsed JSON): ${response.data}');
        } catch (e) {
          print('Failed to parse response as JSON: $e');
          print('Response (before parsing): $responseData');
          if (responseData.contains('}{')) {
            final parts = responseData.split('}{');
            responseData = '{${parts.last}';
            try {
              response.data = jsonDecode(responseData);
              print('Fixed Response (Parsed JSON): ${response.data}');
            } catch (e) {
              print('Failed to fix JSON: $e');
              throw Exception('Invalid JSON format: $responseData');
            }
          } else {
            throw Exception('Invalid JSON format: $responseData');
          }
        }

        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        print('Error [${e.type}] on request to: ${e.requestOptions.uri}');
        print('Error Message: ${e.message}');
        print('Error Response: ${e.response?.data}');
        print('Error Details: ${e.error}');

        if (e.response?.statusCode == 401 && !_isRedirecting) {
          _isRedirecting = true;
          print('Unauthorized access detected, redirecting to SignInScreen...');

          await AppLocalStorage.removeData('token');
          print('Old token removed from AppLocalStorage');

          if (navigatorKey.currentContext != null) {
            ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
              const SnackBar(
                content: Text('Session expired. Please log in again.'),
                backgroundColor: Colors.redAccent,
                duration: Duration(seconds: 2),
              ),
            );
          }

          Future.delayed(const Duration(seconds: 2), () {
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              SignInScreen.routName,
              (route) => false,
            );
          });

          Future.delayed(const Duration(seconds: 3), () {
            _isRedirecting = false;
          });
        }

        return handler.next(e);
      },
    ));
  }

  static Future<String?> _getToken() async {
    final token = AppLocalStorage.getData('token');
    print('Retrieved Token: $token');
    return token as String?;
  }

  static Future<Map<String, String>> _prepareHeaders(
      Map<String, dynamic>? headers,
      {String contentType = 'application/json'}) async {
    final Map<String, String> defaultHeaders = {
      'Content-Type': contentType,
    };

    final bool isGuest = await AppLocalStorage.isGuest();
    final String? token = await _getToken();
    if (token != null &&
        token.isNotEmpty &&
        !isGuest &&
        token != 'your_token_here') {
      defaultHeaders['Authorization'] = 'Bearer $token';
      print('Authorization Header set to: Bearer $token');
    } else {
      print(
          'No valid token or guest mode active, skipping Authorization header');
      defaultHeaders.remove('Authorization');
    }

    if (headers != null) {
      defaultHeaders.addAll(headers.cast<String, String>());
      print('Headers after merging with custom headers: $defaultHeaders');
    }

    return defaultHeaders;
  }

  static Future<Response> get({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String contentType = 'application/x-www-form-urlencoded',
  }) async {
    try {
      final preparedHeaders =
          await _prepareHeaders(headers, contentType: contentType);
      print('GET Request to: ${AppEndpoints.baseUrl}$endpoint');
      print('Headers: $preparedHeaders');
      print('Data: $data');
      print('Query Parameters: $queryParameters');
      final response = await _dio.get(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: preparedHeaders,
          responseType: ResponseType.plain,
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(
            'Connection timeout while making GET request to $endpoint');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
            'Receive timeout while making GET request to $endpoint');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response from $endpoint: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception(
            'DioException [${e.type}]: ${e.message} - ${e.response?.data}');
      }
    } catch (e) {
      throw Exception('Error making GET request to $endpoint: $e');
    }
  }

  static Future<Response> post({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? headers,
    String contentType = 'multipart/form-data',
  }) async {
    try {
      final preparedHeaders =
          await _prepareHeaders(headers, contentType: contentType);
      print('POST Request to: ${AppEndpoints.baseUrl}$endpoint');
      print('Headers: $preparedHeaders');
      print('Data: $data');
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: preparedHeaders,
          responseType: ResponseType.plain,
        ),
      );
      print('Response: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(
            'Connection timeout while making POST request to $endpoint');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
            'Receive timeout while making POST request to $endpoint');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response from $endpoint: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception(
            'DioException [${e.type}]: ${e.message} - ${e.response?.data}');
      }
    } catch (e) {
      throw Exception('Error making POST request to $endpoint: $e');
    }
  }

  static Future<Response> put({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? headers,
    String contentType = 'application/json',
  }) async {
    try {
      final preparedHeaders =
          await _prepareHeaders(headers, contentType: contentType);
      print('PUT Request to: ${AppEndpoints.baseUrl}$endpoint');
      print('Headers: $preparedHeaders');
      print('Data: $data');
      final response = await _dio.put(
        endpoint,
        data: data,
        options: Options(headers: preparedHeaders),
      );
      print('Response: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(
            'Connection timeout while making PUT request to $endpoint');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
            'Receive timeout while making PUT request to $endpoint');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response from $endpoint: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception(
            'DioException [${e.type}]: ${e.message} - ${e.response?.data}');
      }
    } catch (e) {
      throw Exception('Error making PUT request to $endpoint: $e');
    }
  }

  static Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    String contentType = 'application/json',
  }) async {
    try {
      final preparedHeaders =
          await _prepareHeaders(headers, contentType: contentType);
      print('DELETE Request to: ${AppEndpoints.baseUrl}$endpoint');
      print('Headers: $preparedHeaders');
      print('Data: $data');
      final response = await _dio.delete(
        endpoint,
        data: data,
        options: Options(headers: preparedHeaders),
      );
      print('Response: ${response.data}');
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(
            'Connection timeout while making DELETE request to $endpoint');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
            'Receive timeout while making DELETE request to $endpoint');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response from $endpoint: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception(
            'DioException [${e.type}]: ${e.message} - ${e.response?.data}');
      }
    } catch (e) {
      throw Exception('Error making DELETE request to $endpoint: $e');
    }
  }
}
