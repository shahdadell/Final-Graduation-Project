import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'package:graduation_project/home_screen/data/model/category_model/category_datum.dart';
import 'package:graduation_project/home_screen/data/repo/home_repo.dart';
import '../../data/model/home_model_response/Categorydatum.dart';
import '../../data/model/home_model_response/items_model.dart';
import '../../data/model/topSelling_model_response/TopSellinModelResponse.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<FetchHomeDataEvent>(fetchHomeData);
    on<FetchOffersEvent>(fetchOffers);
    on<FetchTopSellingEvent>(fetchTopSelling);
    on<FetchCategoriesEvent>(fetchCategories);
    on<FetchDiscountEvent>(fetchDiscountedItems);
    on<FetchServicesEvent>(fetchServicesByCategory);
    on<FetchServiceItemsEvent>(fetchServiceItems);
    on<FetchSearchEvent>(fetchSearch);
    on<ClearSearchEvent>((event, emit) {
      if (kDebugMode) {
        print('ClearSearchEvent Triggered');
      }
      emit(HomeInitialState());
    });
  }

  Future<void> fetchHomeData(
      FetchHomeDataEvent event, Emitter<HomeState> emit) async {
    if (kDebugMode) {
      print("FetchHomeDataEvent Started");
    }
    if (state is FetchLoadingHomeDataState) return; // Prevent duplicate calls
    emit(FetchLoadingHomeDataState());
    try {
      final results = await Future.wait([
        HomeRepo.fetchCategories().catchError((e) {
          if (kDebugMode) print("Error fetching categories: $e");
          return <Categorydatum>[]; // Return empty list of correct type
        }),
        HomeRepo.fetchDiscountedItems().catchError((e) {
          if (kDebugMode) print("Error fetching discounted items: $e");
          return <ItemModel>[]; // Return empty list of correct type
        }),
        HomeRepo.fetchTopSelling().catchError((e) {
          if (kDebugMode) print("Error fetching top selling: $e");
          return TopSellingModelResponse(items: Items(data: [])); // Return empty response
        }),
      ], eagerError: true);

      final categories = results[0] as List<Categorydatum>;
      final items = results[1] as List<ItemModel>;
      final topSellingModel = results[2] as TopSellingModelResponse;

      if (kDebugMode) {
        print("FetchHomeDataEvent Succeeded");
        print(
            "Categories: ${categories.length}, Items: ${items.length}, TopSelling: ${topSellingModel.items?.data?.length}");
      }

      emit(FetchSuccessHomeDataState(
        categories: categories,
        items: items,
        topSelling: topSellingModel.items?.data ?? [],
      ));
    } catch (e) {
      if (kDebugMode) {
        print("Error in fetchHomeData: $e");
      }
      emit(HomeErrorState(message: 'Error loading home data: $e'));
    }
  }

  Future<void> fetchOffers(
      FetchOffersEvent event, Emitter<HomeState> emit) async {
    if (kDebugMode) {
      print("FetchOffersEvent Started");
    }
    emit(FetchOffersLoadingState());
    try {
      final offers = await HomeRepo.fetchOffers();
      if (kDebugMode) {
        print("FetchOffersEvent Succeeded with ${offers.length} offers");
      }
      emit(FetchOffersSuccessState(offers: offers));
    } catch (e) {
      if (kDebugMode) {
        print("FetchOffersEvent Failed: $e");
      }
      emit(FetchOffersErrorState(message: e.toString()));
    }
  }

  Future<void> fetchTopSelling(
      FetchTopSellingEvent event, Emitter<HomeState> emit) async {
    if (kDebugMode) {
      print("FetchTopSellingEvent Started");
    }
    emit(FetchTopSellingLoadingState());
    try {
      final topSellingResponse = await HomeRepo.fetchTopSelling();
      final topSellingItems = topSellingResponse.items?.data ?? [];
      if (kDebugMode) {
        print(
            "FetchTopSellingEvent Succeeded with ${topSellingItems.length} items");
      }
      emit(FetchTopSellingSuccessState(topSelling: topSellingItems));
    } catch (e) {
      if (kDebugMode) {
        print("FetchTopSellingEvent Failed: $e");
      }
      emit(FetchTopSellingErrorState(message: e.toString()));
    }
  }

  Future<void> fetchCategories(
      FetchCategoriesEvent event, Emitter<HomeState> emit) async {
    if (kDebugMode) {
      print("FetchCategoriesEvent Started");
    }
    emit(FetchCategoriesLoadingState());
    try {
      final categories = await HomeRepo.fetchCategories();
      if (kDebugMode) {
        print(
            "FetchCategoriesEvent Succeeded with ${categories.length} categories");
      }
      emit(FetchCategoriesSuccessState(categories: categories));
    } catch (e) {
      if (kDebugMode) {
        print("FetchCategoriesEvent Failed: $e");
      }
      emit(FetchCategoriesErrorState(message: e.toString()));
    }
  }

  Future<void> fetchDiscountedItems(
      FetchDiscountEvent event, Emitter<HomeState> emit) async {
    if (kDebugMode) {
      print("FetchDiscountEvent Started");
    }
    emit(FetchDiscountItemsLoadingState());
    try {
      final items = await HomeRepo.fetchDiscountedItems();
      if (kDebugMode) {
        print("FetchDiscountEvent Succeeded with ${items.length} items");
      }
      emit(FetchDiscountItemsSuccessState(items: items));
    } catch (e) {
      if (kDebugMode) {
        print("FetchDiscountEvent Failed: $e");
      }
      emit(FetchDiscountItemsErrorState(message: e.toString()));
    }
  }

  Future<void> fetchServicesByCategory(
      FetchServicesEvent event, Emitter<HomeState> emit) async {
    if (kDebugMode) {
      print("FetchServicesEvent Started for category ${event.categoryId}");
    }
    emit(FetchServicesLoadingState());
    try {
      final services = await HomeRepo.fetchServicesByCategory(event.categoryId);
      if (kDebugMode) {
        print("FetchServicesEvent Succeeded with ${services.length} services");
      }
      emit(FetchServicesSuccessState(services: services));
    } catch (e) {
      if (kDebugMode) {
        print("FetchServicesEvent Failed: $e");
      }
      emit(FetchServicesErrorState(message: e.toString()));
    }
  }

  Future<void> fetchServiceItems(
      FetchServiceItemsEvent event, Emitter<HomeState> emit) async {
    if (kDebugMode) {
      print("FetchServiceItemsEvent Started for service ${event.serviceId}, userId ${event.userId}");
    }
    emit(FetchServiceItemsLoadingState());
    try {
      final items = await HomeRepo.fetchServiceItems(
        serviceId: event.serviceId,
        userId: event.userId,
      );
      if (kDebugMode) {
        print("FetchServiceItemsEvent Succeeded with ${items.length} items");
        // Log the items to debug
        for (var item in items) {
          print("Item: ${item.itemsName}, ID: ${item.itemsId}");
        }
      }
      emit(FetchServiceItemsSuccessState(items: items));
    } catch (e) {
      if (kDebugMode) {
        print("FetchServiceItemsEvent Failed: $e");
      }
      emit(FetchServiceItemsErrorState(message: e.toString()));
    }
  }

  Future<void> fetchSearch(
      FetchSearchEvent event, Emitter<HomeState> emit) async {
    if (kDebugMode) {
      print("FetchSearchEvent Started with query: ${event.query}");
    }
    emit(FetchSearchLoadingState());
    try {
      final searchResults = await HomeRepo.fetchSearch(event.query);
      final services = searchResults.services?.data ?? [];
      final items = searchResults.items?.data ?? [];
      if (kDebugMode) {
        print(
            "FetchSearchEvent Succeeded with ${services.length} services and ${items.length} items");
      }
      emit(FetchSearchSuccessState(services: services, items: items));
    } catch (e) {
      if (kDebugMode) {
        print("FetchSearchEvent Failed: $e");
      }
      emit(FetchSearchErrorState(message: e.toString()));
    }
  }
}