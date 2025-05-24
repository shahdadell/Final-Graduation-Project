// lib/home_screen/bloc/Home/home_event.dart
import 'package:graduation_project/home_screen/data/model/home_model_response/home_model_response.dart';

abstract class HomeEvent {}

class FetchHomeDataEvent extends HomeEvent {
  final HomeModelResponse? params;
  FetchHomeDataEvent(this.params);
}

class FetchOffersEvent extends HomeEvent {}

class FetchTopSellingEvent extends HomeEvent {}

class FetchCategoriesEvent extends HomeEvent {
  final HomeModelResponse? params;
  FetchCategoriesEvent(this.params);
}

class FetchDiscountEvent extends HomeEvent {
  final HomeModelResponse? params;
  FetchDiscountEvent(this.params);
}

class FetchServicesEvent extends HomeEvent {
  final int categoryId;
  FetchServicesEvent(this.categoryId);
}

class FetchServiceItemsEvent extends HomeEvent {
  final int serviceId;
  final int userId;
  FetchServiceItemsEvent({required this.serviceId, required this.userId});
}

class FetchSearchEvent extends HomeEvent {
  final String query;
  FetchSearchEvent(this.query);
}

class ClearSearchEvent extends HomeEvent {} // أضفنا ClearSearchEvent
