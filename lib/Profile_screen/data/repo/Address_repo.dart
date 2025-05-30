import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/API_Services/endpoints.dart';
import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/add_new_address/add_new_address.dart';
import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/delete_address.dart';
import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/edit_addresses.dart';
import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/view_addresses/view_addresses.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

class AddressRepo {
  Future<Map<String, String>> _getAuthHeaders(
      {required bool includeAuth}) async {
    Map<String, String> headers = {
      'Content-Type':
          'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW',
    };
    if (includeAuth) {
      final String? token = AppLocalStorage.getData('token');
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<ViewAddresses> fetchAddresses() async {
    try {
      final int? userId = AppLocalStorage.getData('user_id');
      print('UserId: $userId');
      final String? token = AppLocalStorage.getData('token');
      print('Token: $token');
      final String endpoint = AppEndpoints.viewAddresses;

      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
      });
      print('Fetch Addresses Request: $formData');

      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
        headers: await _getAuthHeaders(includeAuth: true),
      );

      print('Fetch Addresses Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) throw Exception('Response data is null');
        return ViewAddresses.fromJson(response.data);
      }
      throw Exception(
          'Failed to fetch addresses - Status: ${response.statusCode}');
    } on DioException catch (e) {
      print('DioException in fetchAddresses: ${e.message}');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while fetching addresses');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while fetching addresses');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error fetching addresses: ${e.message}');
      }
    } catch (e) {
      print('Error fetching addresses: $e');
      throw Exception('Error fetching addresses: $e');
    }
  }

  Future<AddNewAddress> addAddress({
    required String addressTitle,
    required String addressPhone, // جديد: addressPhone
    required String addressDetails,
    required String addressLatitude,
    required String addressLongitude,
    required String addressCity,
  }) async {
    try {
      final int? userId = AppLocalStorage.getData('user_id');
      print('UserId: $userId');
      final String? token = AppLocalStorage.getData('token');
      print('Token: $token');
      final String endpoint = AppEndpoints.addAddress;

      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
        'name': addressTitle,
        'phone': addressPhone, // السيرفر متوقع "phone"
        'city': addressCity,
        'street': addressDetails,
        'lat': addressLatitude,
        'long': addressLongitude,
      });
      print('Add Address Request: $formData');

      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
        headers: await _getAuthHeaders(includeAuth: true),
      );

      print('Raw Response Data: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) throw Exception('Response data is null');
        return AddNewAddress.fromJson(response.data);
      }
      throw Exception('Failed to add address - Status: ${response.statusCode}');
    } on DioException catch (e) {
      print('DioException in addAddress: ${e.message}');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while adding address');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while adding address');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error adding address: ${e.message}');
      }
    } catch (e) {
      print('Error adding address: $e');
      throw Exception('Error adding address: $e');
    }
  }

  Future<DeleteAddress> deleteAddress({required String addressId}) async {
    try {
      final int? userId = AppLocalStorage.getData('user_id');
      print('UserId: $userId');
      final String? token = AppLocalStorage.getData('token');
      print('Token: $token');
      final String endpoint = AppEndpoints.deleteAddress;

      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
        'addressid': addressId,
      });
      print('Delete Address Request: $formData');

      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
        headers: await _getAuthHeaders(includeAuth: true),
      );

      print('Delete Address Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) throw Exception('Response data is null');
        return DeleteAddress.fromJson(response.data);
      }
      throw Exception(
          'Failed to delete address - Status: ${response.statusCode}');
    } on DioException catch (e) {
      print('DioException in deleteAddress: ${e.message}');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while deleting address');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while deleting address');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error deleting address: ${e.message}');
      }
    } catch (e) {
      print('Error deleting address: $e');
      throw Exception('Error deleting address: $e');
    }
  }

  Future<EditAddresses> editAddress({
    required String addressId,
    required String name,
    required String addressPhone, // جديد: addressPhone
    required String city,
    required String street,
    required String lat,
    required String long,
  }) async {
    try {
      final int? userId = AppLocalStorage.getData('user_id');
      print('UserId: $userId');
      final String? token = AppLocalStorage.getData('token');
      print('Token: $token');
      final String endpoint = AppEndpoints.editAddress;

      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
        'addressid': addressId,
        'name': name,
        'phone': addressPhone, // السيرفر متوقع "phone"
        'city': city,
        'street': street,
        'lat': lat,
        'long': long,
      });
      print('Edit Address Request: $formData');

      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
        headers: await _getAuthHeaders(includeAuth: true),
      );

      print('Edit Address Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) throw Exception('Response data is null');
        return EditAddresses.fromJson(response.data);
      }
      throw Exception(
          'Failed to edit address - Status: ${response.statusCode}');
    } on DioException catch (e) {
      print('DioException in editAddress: ${e.message}');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while editing address');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while editing address');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error editing address: ${e.message}');
      }
    } catch (e) {
      print('Error editing address: $e');
      throw Exception('Error editing address: $e');
    }
  }
}
