import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/API_Services/endpoints.dart';
import 'package:graduation_project/home_screen/data/model/orders_model_response/details_response/DetailsResponse.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import '../model/orders_model_response/ArchiveResponse.dart';
import '../model/orders_model_response/CheckOutResponse.dart';
import '../model/orders_model_response/PendingResponse.dart';
import '../model/orders_model_response/DeleteResponse.dart';

class OrderRepo {
  static Future<CheckOutResponse> checkout({
    required int userId,
    required int addressId,
    required int orderstype,
    required double priceDelivery,
    required double ordersPrice,
    int? couponId,
    required int paymentMethod,
    required double couponDiscount,
  }) async {
    try {
      final token = await AppLocalStorage.getData('token');

      var formData = FormData.fromMap({
        'usersid': userId.toString(),
        'addressid': addressId.toString(),
        'orderstype': orderstype.toString(),
        'pricedelivery': priceDelivery.toString(),
        'ordersprice': ordersPrice.toString(),
        'couponid': couponId?.toString() ?? '',
        'paymentmethod': paymentMethod.toString(),
        'coupondiscount': couponDiscount.toString(),
      });

      log('Checkout Request URL: ${AppEndpoints.baseUrl}${AppEndpoints.checkout}');
      log('Checkout Request Body: ${formData.fields}');
      log('Checkout Request Headers: Authorization: Bearer $token');

      var response = await DioProvider.post(
        endpoint: AppEndpoints.checkout,
        data: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      log('Checkout Response Status Code: ${response.statusCode}');
      log('Checkout Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          return CheckOutResponse.fromJson(response.data);
        } else {
          throw Exception(
              'Checkout failed: ${response.data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
            'Failed to checkout: Status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException in checkout: $e');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while checking out');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while checking out');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error during checkout: ${e.message}');
      }
    } catch (e) {
      log('Exception in checkout: $e');
      throw Exception('Error during checkout: $e');
    }
  }

  Future<PendingResponse> fetchPendingOrders(int userId) async {
    try {
      final token = await AppLocalStorage.getData('token');

      var formData = FormData.fromMap({
        'userid': userId.toString(),
      });

      log('Fetch Pending Orders Request URL: ${AppEndpoints.baseUrl}orders/pending.php');
      log('Fetch Pending Orders Request Body: ${formData.fields}');
      log('Fetch Pending Orders Request Headers: Authorization: Bearer $token');

      var response = await DioProvider.post(
        endpoint: 'orders/pending.php',
        data: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      log('Fetch Pending Orders Response Status Code: ${response.statusCode}');
      log('Fetch Pending Orders Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          return PendingResponse.fromJson(response.data);
        } else {
          throw Exception(
              'Failed to fetch pending orders: ${response.data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
            'Failed to fetch pending orders: Status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException in fetchPendingOrders: $e');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while fetching pending orders');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while fetching pending orders');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error during fetching pending orders: ${e.message}');
      }
    } catch (e) {
      log('Exception in fetchPendingOrders: $e');
      throw Exception('Error during fetching pending orders: $e');
    }
  }

  Future<ArchiveResponse> fetchArchivedOrders(int userId) async {
    try {
      final token = await AppLocalStorage.getData('token');

      var formData = FormData.fromMap({
        'userid': userId.toString(),
      });

      log('Fetch Archived Orders Request URL: ${AppEndpoints.baseUrl}orders/archive.php');
      log('Fetch Archived Orders Request Body: ${formData.fields}');
      log('Fetch Archived Orders Request Headers: Authorization: Bearer $token');

      var response = await DioProvider.post(
        endpoint: 'orders/archive.php',
        data: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      log('Fetch Archived Orders Response Status Code: ${response.statusCode}');
      log('Fetch Archived Orders Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          return ArchiveResponse.fromJson(response.data);
        } else {
          throw Exception(
              'Failed to fetch archived orders: ${response.data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
            'Failed to fetch archived orders: Status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException in fetchArchivedOrders: $e');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while fetching archived orders');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while fetching archived orders');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error during fetching archived orders: ${e.message}');
      }
    } catch (e) {
      log('Exception in fetchArchivedOrders: $e');
      throw Exception('Error during fetching archived orders: $e');
    }
  }

  Future<DetailsResponse> fetchOrderDetails(String ordersId) async {
    try {
      final token = await AppLocalStorage.getData('token');

      var formData = FormData.fromMap({
        'ordersid': ordersId,
      });

      log('Fetch Order Details Request URL: ${AppEndpoints.baseUrl}orders/details.php');
      log('Fetch Order Details Request Body: ${formData.fields}');
      log('Fetch Order Details Request Headers: Authorization: Bearer $token');

      var response = await DioProvider.post(
        endpoint: 'orders/details.php',
        data: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      log('Fetch Order Details Response Status Code: ${response.statusCode}');
      log('Fetch Order Details Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          return DetailsResponse.fromJson(response.data);
        } else {
          throw Exception(
              'Failed to fetch order details: ${response.data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
            'Failed to fetch order details: Status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException in fetchOrderDetails: $e');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while fetching order details');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while fetching order details');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error during fetching order details: ${e.message}');
      }
    } catch (e) {
      log('Exception in fetchOrderDetails: $e');
      throw Exception('Error during fetching order details: $e');
    }
  }

  Future<void> archiveOrder(String orderId) async {
    try {
      final token = await AppLocalStorage.getData('token');

      var formData = FormData.fromMap({
        'ordersid': orderId,
      });

      log('Archive Order Request URL: ${AppEndpoints.baseUrl}orders/archive_order.php');
      log('Archive Order Request Body: ${formData.fields}');
      log('Archive Order Request Headers: Authorization: Bearer $token');

      var response = await DioProvider.post(
        endpoint: 'orders/archive_order.php',
        data: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      log('Archive Order Response Status Code: ${response.statusCode}');
      log('Archive Order Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          return;
        } else {
          throw Exception(
              'Failed to archive order: ${response.data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
            'Failed to archive order: Status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException in archiveOrder: $e');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while archiving order');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while archiving order');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error during archiving order: ${e.message}');
      }
    } catch (e) {
      log('Exception in archiveOrder: $e');
      throw Exception('Error during archiving order: $e');
    }
  }

  Future<DeleteResponse> deleteOrder(String orderId) async {
    try {
      final token = await AppLocalStorage.getData('token');

      var formData = FormData.fromMap({
        'ordersid': orderId,
      });

      // Updated endpoint to the correct one
      const deleteEndpoint = 'orders/delete.php';

      log('Delete Order Request URL: ${AppEndpoints.baseUrl}$deleteEndpoint');
      log('Delete Order Request Body: ${formData.fields}');
      log('Delete Order Request Headers: Authorization: Bearer $token');

      var response = await DioProvider.post(
        endpoint: deleteEndpoint,
        data: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      log('Delete Order Response Status Code: ${response.statusCode}');
      log('Delete Order Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final deleteResponse = DeleteResponse.fromJson(response.data);
        if (deleteResponse.status == 'success') {
          return deleteResponse;
        } else {
          throw Exception(
              'Failed to delete order: ${response.data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
            'Failed to delete order: Status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      log('DioException in deleteOrder: $e');
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while deleting order');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while deleting order');
      } else if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 404) {
          throw Exception(
              'Delete endpoint not found (404). Please verify the endpoint: ${AppEndpoints.baseUrl}orders/delete.php');
        }
        throw Exception(
            'Bad response from orders/delete.php: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error during deleting order: ${e.message}');
      }
    } catch (e) {
      log('Exception in deleteOrder: $e');
      throw Exception('Error during deleting order: $e');
    }
  }
}
