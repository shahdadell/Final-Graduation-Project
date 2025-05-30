import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/API_Services/endpoints.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/data/model/add_to_favourite.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/data/model/delete_from_fav.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/data/model/view_favourite_list.dart';

class FavoriteRepo {
  static Future<AddtoFavourite> addToFavorite({
    required int userId,
    required int itemId,
  }) async {
    try {
      const String endpoint = AppEndpoints.addToFavourite;
      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
        'itemsid': itemId.toString(),
      });
      log('Add to Favorite Request: $formData');
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      log('Add to Favorite Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return AddtoFavourite.fromJson(response.data);
      }
      throw Exception(
          'Failed to add item to favorite - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while adding to favorite');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while adding to favorite');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error adding to favorite: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error adding to favorite: $e');
    }
  }

  static Future<ViewFavouriteList> fetchFavorite({
    required int userId,
  }) async {
    try {
      const String endpoint = AppEndpoints.viewFavourite;
      final FormData formData = FormData.fromMap({
        'id': userId.toString(),
      });
      log('Fetch Favorite Request: $formData');
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      log('Fetch Favorite Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return ViewFavouriteList.fromJson(response.data);
      }
      throw Exception(
          'Failed to fetch favorite - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while fetching favorite');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while fetching favorite');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error fetching favorite: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching favorite: $e');
    }
  }

  static Future<DeleteFromFav> deleteFavoriteItem({
    required int userId,
    required int itemId,
  }) async {
    try {
      const String endpoint = AppEndpoints.removeFavourite;
      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
        'itemsid': itemId.toString(),
      });
      log('Delete Favorite Item Request: $formData');
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      log('Delete Favorite Item Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return DeleteFromFav.fromJson(response.data);
      }
      throw Exception(
          'Failed to delete favorite item - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while deleting favorite item');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while deleting favorite item');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error deleting favorite item: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error deleting favorite item: $e');
    }
  }

  static Future<bool> checkFavoriteStatus({
    required int userId,
    required int itemId,
  }) async {
    try {
      const String endpoint = AppEndpoints.viewFavourite;
      final FormData formData = FormData.fromMap({
        'id': userId.toString(),
      });
      log('Check Favorite Status Request: $formData');
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      log('Check Favorite Status Response: ${response.data}');
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        final favoriteList = ViewFavouriteList.fromJson(response.data);
        return favoriteList.data?.any((item) =>
                item.itemsId == itemId.toString() ||
                item.favoriteItemsid == itemId.toString()) ??
            false;
      }
      throw Exception(
          'Failed to check favorite status - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while checking favorite status');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while checking favorite status');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
            'Connection error: Please check your internet connection');
      } else {
        throw Exception('Error checking favorite status: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error checking favorite status: $e');
    }
  }
}
