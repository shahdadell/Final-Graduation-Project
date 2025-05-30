import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/API_Services/endpoints.dart';
import 'package:graduation_project/home_screen/data/model/category_model/category_datum.dart';
import 'package:graduation_project/home_screen/data/model/home_model_response/Categorydatum.dart';
import 'package:graduation_project/home_screen/data/model/home_model_response/items_model.dart';
import 'package:graduation_project/home_screen/data/model/item_model_response/Itemdatum.dart';
import 'package:graduation_project/home_screen/data/model/offers_model_response/offers_model_response/offers_model_response.dart';
import 'package:graduation_project/home_screen/data/model/services_model_response/service_model.dart';
import 'package:graduation_project/home_screen/data/model/topSelling_model_response/TopSellinModelResponse.dart';
import 'package:graduation_project/home_screen/data/model/search_model_response/SearchModelResponse.dart' as search;
import '../../../local_data/shared_preference.dart';
import '../model/Cart_model_response/CartAddResponse.dart';

class HomeRepo {
  // Updated at 01:44 AM EEST, Wednesday, May 28, 2025
  static Future<List<Categorydatum>> fetchCategories() async {
    try {
      var response = await DioProvider.get(endpoint: AppEndpoints.fetchHome);
      if (kDebugMode) {
        print("Fetch Categories Status Code: ${response.statusCode}");
        print("Fetch Categories Response: ${response.data}");
      }

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        List<dynamic>? categoriesData = response.data['categories']?['data'] as List<dynamic>?;

        if (categoriesData != null && categoriesData.isNotEmpty) {
          if (kDebugMode) {
            print("Categories Data Parsed: ${categoriesData.length} categories");
          }
          return categoriesData
              .map((e) => Categorydatum.fromJson(e))
              .where((category) => category.isDeleted == "0") // تصفية الكاتيجوريز الغير محذوفة
              .toList();
        } else {
          throw Exception('Categories data is null or empty');
        }
      } else {
        throw Exception(
            'Failed to fetch categories: ${response.data['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception in fetchCategories: $e");
      }
      throw Exception('Error fetching categories: $e');
    }
  }

  // Updated at 10:33 PM EEST, Tuesday, May 27, 2025
  static Future<List<ItemModel>> fetchDiscountedItems() async {
    try {
      var response = await DioProvider.get(endpoint: AppEndpoints.fetchHome);
      if (kDebugMode) {
        print("Fetch Discounted Items Status Code: ${response.statusCode}");
        print("Fetch Discounted Items Response: ${response.data}");
      }

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        List<dynamic>? itemsData = response.data['items']?['data'] as List<dynamic>?;

        if (itemsData != null && itemsData.isNotEmpty) {
          if (kDebugMode) {
            print("Discounted Items Data Parsed: ${itemsData.length} items");
          }
          return itemsData.map((e) => ItemModel.fromJson(e)).toList();
        } else {
          throw Exception('Discounted items data is null or missing');
        }
      } else {
        throw Exception(
            'Failed to fetch discounted items: ${response.data['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception in fetchDiscountedItems: $e");
      }
      throw Exception('Error fetching discounted items: $e');
    }
  }

  // Updated at 03:04 AM EEST, Saturday, May 24, 2025
  static Future<List<OffersModelResponse>> fetchOffers() async {
    try {
      var response = await DioProvider.get(endpoint: AppEndpoints.offersSlider);
      log('Fetch Offers Response Status Code: ${response.statusCode}');
      log('Fetch Offers Response Data: ${response.data}');

      if (response.statusCode == 200) {
        List<dynamic> offersData = response.data;
        return offersData.map((e) => OffersModelResponse.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to fetch offers: ${response.data['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      log('Exception in fetchOffers: $e');
      throw Exception('Error fetching offers: $e');
    }
  }

  // Updated at 03:04 AM EEST, Saturday, May 24, 2025
  static Future<TopSellingModelResponse> fetchTopSelling() async {
    try {
      var response = await DioProvider.get(endpoint: AppEndpoints.topSelling);
      if (kDebugMode) {
        print("Fetch TopSelling Status Code: ${response.statusCode}");
        print("Fetch TopSelling Response: ${response.data}");
      }
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        if (kDebugMode) {
          print(
              "TopSelling Data Parsed: ${TopSellingModelResponse.fromJson(response.data).items?.data?.length} items");
        }
        return TopSellingModelResponse.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch TopSelling: ${response.data['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception in fetchTopSelling: $e");
      }
      throw Exception('Error fetching TopSelling: $e');
    }
  }

  // Updated at 03:04 AM EEST, Saturday, May 24, 2025
  static Future<List<ServiceModel>> fetchServicesByCategory(int serviceId) async {
    try {
      final token = await AppLocalStorage.getData('token');
      var response = await DioProvider.get(
        endpoint: "${AppEndpoints.fetchService}?id=$serviceId",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        List servicesData = response.data['data'];
        return servicesData.map((e) => ServiceModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch services');
      }
    } catch (e) {
      log('Exception: $e');
      throw Exception('Error fetching services');
    }
  }

  // Updated at 03:04 AM EEST, Saturday, May 24, 2025
  static Future<List<ItemDatum>> fetchServiceItems({
    required int serviceId,
    required int userId,
  }) async {
    try {
      final token = await AppLocalStorage.getData('token');
      var response = await DioProvider.post(
        endpoint: "${AppEndpoints.fetchItems}?id=$serviceId&userid=$userId",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      log('Response Status Code: ${response.statusCode}');
      log('Full Response: ${response.toString()}');
      log('Response Data: ${response.data.toString()}');

      if (response.statusCode == 200) {
        if (response.data != null && response.data['status'] == 'success') {
          if (response.data['data'] != null) {
            List itemsData = response.data['data'];
            log('Items Data: $itemsData');
            return itemsData.map((e) => ItemDatum.fromJson(e)).toList();
          } else {
            throw Exception('No data found in response');
          }
        } else {
          throw Exception(
              'API returned status: ${response.data['status']} - Message: ${response.data['message'] ?? 'No message'}');
        }
      } else {
        throw Exception(
            'Failed to fetch service items - Status Code: ${response.statusCode}');
      }
    } catch (e) {
      log('Exception Details: $e');
      throw Exception('Error fetching service items: $e');
    }
  }

  static Future<search.SearchModelResponse> fetchSearch(String query) async {
    try {
      final token = await AppLocalStorage.getData('token');

      var formData = FormData.fromMap({
        'search': query,
      });
      var response = await DioProvider.post(
        endpoint: AppEndpoints.search,
        data: formData,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      );

      log('Search Response Status Code: ${response.statusCode}');
      log('Search Response Data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          final searchResponse = search.SearchModelResponse.fromJson(response.data);
          log('Parsed SearchModelResponse: $searchResponse');
          return searchResponse;
        } else {
          throw Exception(
              'Search failed: ${response.data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception(
            'Failed to fetch search results: Status code ${response.statusCode}');
      }
    } catch (e) {
      log('Exception in fetchSearch: $e');
      if (e.toString().contains('FormatException')) {
        throw Exception(
            'Error fetching search results: Invalid response format from server');
      }
      throw Exception('Error fetching search results: $e');
    }
  }

  static Future<CartAddResponse> addItemToCart({
    required int userId,
    required int itemId,
  }) async {
    try {
      var requestBody = {
        'usersid': userId.toString(),
        'itemsid': itemId.toString(),
      };

      log('Add to Cart Request URL: ${AppEndpoints.baseUrl}cart/add.php');
      log('Add to Cart Request Body: ${jsonEncode(requestBody)}');

      var response = await DioProvider.post(
        endpoint: "${AppEndpoints.addToCart}?id=$itemId&userid=$userId",
        data: requestBody,
        headers: {'Content-Type': 'application/json'},
      );

      log('Add to Cart Response Status: ${response.statusCode}');
      log('Add to Cart Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return CartAddResponse.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to add item to cart: ${response.statusCode} - ${response.data['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      log('Exception in Add to Cart: $e');
      throw Exception('Error adding item to cart: $e');
    }
  }
}