import 'package:graduation_project/home_screen/data/model/Cart_model_response/CartAddResponse.dart';
import 'package:graduation_project/home_screen/data/model/Cart_model_response/CartGetCountTimesResponse.dart';
import 'package:graduation_project/home_screen/data/model/Cart_model_response/CartViewResponse.dart';
import 'package:graduation_project/home_screen/data/model/Cart_model_response/CartDeleteResponse.dart';
import '../../data/model/couponname_model_Response/CouponeResponse.dart';

class CartState {}

class CartInitialState extends CartState {}

class AddToCartLoadingState extends CartState {}

class AddToCartSuccessState extends CartState {
  final CartAddResponse cartResponse;

  AddToCartSuccessState({required this.cartResponse});
}

class AddToCartErrorState extends CartState {
  final String message;

  AddToCartErrorState({required this.message});
}

class GetCartItemCountLoadingState extends CartState {}

class GetCartItemCountSuccessState extends CartState {
  final CartGetCountTimesResponse countResponse;
  final int? itemId;

  GetCartItemCountSuccessState({required this.countResponse, this.itemId});
}

class GetCartItemCountErrorState extends CartState {
  final String message;

  GetCartItemCountErrorState({required this.message});
}

class FetchCartLoadingState extends CartState {}

class FetchCartSuccessState extends CartState {
  final CartViewResponse cartViewResponse;

  FetchCartSuccessState({required this.cartViewResponse});
}

class FetchCartErrorState extends CartState {
  final String message;

  FetchCartErrorState({required this.message});
}

class DeleteCartItemLoadingState extends CartState {}

class DeleteCartItemSuccessState extends CartState {
  final CartDeleteResponse deleteResponse;

  DeleteCartItemSuccessState({required this.deleteResponse});
}

class DeleteCartItemErrorState extends CartState {
  final String message;

  DeleteCartItemErrorState({required this.message});
}

class CheckCouponLoadingState extends CartState {}

class CheckCouponSuccessState extends CartState {
  final CouponeResponse couponResponse;

  CheckCouponSuccessState({required this.couponResponse});
}

class CheckCouponErrorState extends CartState {
  final String message;

  CheckCouponErrorState({required this.message});
}
