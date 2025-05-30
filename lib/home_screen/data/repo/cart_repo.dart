import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/API_Services/endpoints.dart';
import '../model/Cart_model_response/CartAddResponse.dart';
import '../model/Cart_model_response/CartGetCountTimesResponse.dart';
import '../model/Cart_model_response/CartViewResponse.dart';
import '../model/Cart_model_response/CartDeleteResponse.dart';
import '../model/couponname_model_Response/CouponeResponse.dart';

class CartRepo {
  static Future<CartAddResponse> addToCart({
    required int userId,
    required int itemId,
    int quantity = 1,
    required String type, // تم إضافة حقل type هنا
  }) async {
    try {
      const String endpoint = AppEndpoints.addToCart;
      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
        'itemsid': itemId.toString(),
        'quantity': quantity.toString(),
        'type': type, // تم إضافة حقل type في الـ FormData هنا
      });
      log('Add to Cart Request: $formData');
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      log('Add to Cart Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return CartAddResponse.fromJson(response.data);
      }
      throw Exception(
          'Failed to add item to cart - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while adding to cart');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while adding to cart');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error adding to cart: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  static Future<CartGetCountTimesResponse> getCartItemCount({
    required int userId,
    required int itemId,
  }) async {
    try {
      const String endpoint = AppEndpoints.cartCount;
      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
        'itemsid': itemId.toString(),
      });
      log('Get Cart Item Count Request: $formData');
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );

      log('Get Cart Item Count Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return CartGetCountTimesResponse.fromJson(response.data);
      }
      throw Exception(
          'Failed to get cart item count - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while getting cart item count');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while getting cart item count');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error getting cart item count: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error getting cart item count: $e');
    }
  }

  static Future<CartViewResponse> fetchCart({
    required int userId,
  }) async {
    try {
      const String endpoint = AppEndpoints.viewCart;
      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
      });
      log('Fetch Cart Request: $formData');
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      log('Fetch Cart Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return CartViewResponse.fromJson(response.data);
      }
      throw Exception('Failed to fetch cart - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while fetching cart');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while fetching cart');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error fetching cart: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching cart: $e');
    }
  }

  static Future<CartDeleteResponse> deleteCartItem({
    required int userId,
    required int itemId,
    required String type,
  }) async {
    try {
      const String endpoint = AppEndpoints.cartDelete;
      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
        'itemsid': itemId.toString(),
        'type': type,
      });
      log('Delete Cart Item Request: $formData');
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      log('Delete Cart Item Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return CartDeleteResponse.fromJson(response.data);
      }
      throw Exception(
          'Failed to delete cart item - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while deleting cart item');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while deleting cart item');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error deleting cart item: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error deleting cart item: $e');
    }
  }

  static Future<CouponeResponse> checkCoupon({
    required String couponName,
  }) async {
    try {
      const String endpoint = AppEndpoints.checkCoupon;
      final FormData formData = FormData.fromMap({
        'couponname': couponName,
      });
      log('Check Coupon Request: $formData');
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      log('Check Coupon Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return CouponeResponse.fromJson(response.data);
      }
      throw Exception(
          'Failed to check coupon - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while checking coupon');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while checking coupon');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error checking coupon: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error checking coupon: $e');
    }
  }
}
