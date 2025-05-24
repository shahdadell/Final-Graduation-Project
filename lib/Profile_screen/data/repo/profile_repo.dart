import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/API_Services/endpoints.dart';
import 'package:graduation_project/Profile_screen/data/model/response/profile_screen_response/ProfileScreenResponse.dart';
import 'package:graduation_project/Profile_screen/data/model/response/profile_screen_response/EditeProfileResponse.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

class ProfileRepo {
  Future<ProfileScreenResponse> fetchProfile(String userId) async {
    try {
      final token = await AppLocalStorage.getData('token');
      var formData = FormData.fromMap({
        'users_id': userId, // نبعت users_id في الـ body
      });

      var response = await DioProvider.post(
        endpoint: AppEndpoints.profileView, // "profile/view.php"
        data: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      log('Response Status Code: ${response.statusCode}');
      log('Raw Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          return ProfileScreenResponse.fromJson(response.data);
        } else {
          throw Exception(
              'API returned status: ${response.data['status']}, message: ${response.data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
            'Failed to fetch profile, status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException: ${e.message}, Response: ${e.response?.data}, Error: ${e.error}');
      throw Exception('Error fetching profile: ${e.message}');
    } catch (e) {
      log('Exception: $e');
      throw Exception('Error fetching profile: $e');
    }
  }

  Future<EditeProfileResponse> updateProfile(
    String userId,
    String username,
    String email,
    String phone,
    String? password,
    File? image,
  ) async {
    try {
      var formData = FormData.fromMap({
        "users_id": userId,
        "new_name": username,
        "new_email": email,
        "new_phone": phone,
        if (password != null && password.isNotEmpty) "new_password": password,
        if (image != null)
          "image": await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last),
      });

      var response = await DioProvider.post(
        endpoint: AppEndpoints.profileEdite, // "profile/edit_profile.php"
        data: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      );

      log('Update Response Status Code: ${response.statusCode}');
      log('Update Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          return EditeProfileResponse.fromJson(response.data);
        } else {
          throw Exception(
              'API returned status: ${response.data['status']}, message: ${response.data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
            'Failed to update profile, status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException: ${e.message}, Response: ${e.response?.data}, Error: ${e.error}');
      throw Exception('Error updating profile: ${e.message}');
    } catch (e) {
      log('Exception: $e');
      throw Exception('Error updating profile');
    }
  }
}
