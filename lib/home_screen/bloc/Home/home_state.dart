import 'package:graduation_project/home_screen/data/model/category_model/category_datum.dart';
import 'package:graduation_project/home_screen/data/model/home_model_response/Categorydatum.dart';
import 'package:graduation_project/home_screen/data/model/home_model_response/items_model.dart';
import 'package:graduation_project/home_screen/data/model/item_model_response/Itemdatum.dart';
import 'package:graduation_project/home_screen/data/model/offers_model_response/offers_model_response/offers_model_response.dart';
import 'package:graduation_project/home_screen/data/model/services_model_response/service_model.dart';
import 'package:graduation_project/home_screen/data/model/topSelling_model_response/TopSellinModelResponse.dart';
import 'package:graduation_project/home_screen/data/model/search_model_response/SearchModelResponse.dart'
as search; // Alias

abstract class HomeState {}

class HomeInitialState extends HomeState {}

// Fetch Home Data
class FetchLoadingHomeDataState extends HomeState {}

class FetchSuccessHomeDataState extends HomeState {
  final List<Categorydatum> categories;
  final List<ItemModel> items;
  final List<TopSellingData> topSelling; // أضفنا topSelling
  FetchSuccessHomeDataState({
    required this.categories,
    required this.items,
    required this.topSelling,
  });
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}

// Fetch Offers
class FetchOffersLoadingState extends HomeState {}

class FetchOffersSuccessState extends HomeState {
  final List<OffersModelResponse> offers;
  FetchOffersSuccessState({required this.offers});
}

class FetchOffersErrorState extends HomeState {
  final String message;
  FetchOffersErrorState({required this.message});
}

// Fetch Top Selling
class FetchTopSellingLoadingState extends HomeState {}

class FetchTopSellingSuccessState extends HomeState {
  final List<TopSellingData> topSelling;
  FetchTopSellingSuccessState({required this.topSelling});
}

class FetchTopSellingErrorState extends HomeState {
  final String message;
  FetchTopSellingErrorState({required this.message});
}

// Fetch Categories
class FetchCategoriesLoadingState extends HomeState {}

class FetchCategoriesSuccessState extends HomeState {
  final List<Categorydatum> categories;
  FetchCategoriesSuccessState({required this.categories});
}

class FetchCategoriesErrorState extends HomeState {
  final String message;
  FetchCategoriesErrorState({required this.message});
}

// Fetch Discounted Items
class FetchDiscountItemsLoadingState extends HomeState {}

class FetchDiscountItemsSuccessState extends HomeState {
  final List<ItemModel> items;
  FetchDiscountItemsSuccessState({required this.items});
}

class FetchDiscountItemsErrorState extends HomeState {
  final String message;
  FetchDiscountItemsErrorState({required this.message});
}

// Fetch Services By Category
class FetchServicesLoadingState extends HomeState {}

class FetchServicesSuccessState extends HomeState {
  final List<ServiceModel> services;
  FetchServicesSuccessState({required this.services});
}

class FetchServicesErrorState extends HomeState {
  final String message;
  FetchServicesErrorState({required this.message});
}

// Fetch Service Items
class FetchServiceItemsLoadingState extends HomeState {}

class FetchServiceItemsSuccessState extends HomeState {
  final List<ItemDatum> items;
  FetchServiceItemsSuccessState({required this.items});
}

class FetchServiceItemsErrorState extends HomeState {
  final String message;
  FetchServiceItemsErrorState({required this.message});
}

// Search States
class FetchSearchLoadingState extends HomeState {}

class FetchSearchSuccessState extends HomeState {
  final List<search.Data> services;
  final List<search.ItemData> items;
  FetchSearchSuccessState({required this.services, required this.items});
}

class FetchSearchErrorState extends HomeState {
  final String message;
  FetchSearchErrorState({required this.message});
}