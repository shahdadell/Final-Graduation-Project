import 'package:bloc/bloc.dart';
import 'package:graduation_project/home_screen/data/repo/cart_repo.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo cartRepo;

  CartBloc({required this.cartRepo}) : super(CartInitialState()) {
    on<AddToCartEvent>(_onAddToCart);
    on<GetCartItemCountEvent>(_onGetCartItemCount);
    on<FetchCartEvent>(_onFetchCart);
    on<DeleteCartItemEvent>(_onDeleteCartItem);
    on<CheckCouponEvent>(_onCheckCoupon);
  }

  Future<void> _onAddToCart(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(AddToCartLoadingState());
    try {
      final response = await CartRepo.addToCart(
        userId: event.userId,
        itemId: event.itemId,
        quantity: event.quantity,
        type: event.type, // تم إضافة حقل type هنا
      );
      emit(AddToCartSuccessState(cartResponse: response));
    } catch (e) {
      emit(AddToCartErrorState(message: e.toString()));
    }
  }

  Future<void> _onGetCartItemCount(
      GetCartItemCountEvent event, Emitter<CartState> emit) async {
    emit(GetCartItemCountLoadingState());
    try {
      final response = await CartRepo.getCartItemCount(
        userId: event.userId,
        itemId: event.itemId,
      );
      emit(GetCartItemCountSuccessState(
        countResponse: response,
        itemId: event.itemId,
      ));
    } catch (e) {
      emit(GetCartItemCountErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchCart(
      FetchCartEvent event, Emitter<CartState> emit) async {
    emit(FetchCartLoadingState());
    try {
      final response = await CartRepo.fetchCart(userId: event.userId);
      emit(FetchCartSuccessState(cartViewResponse: response));
    } catch (e) {
      emit(FetchCartErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteCartItem(
      DeleteCartItemEvent event, Emitter<CartState> emit) async {
    emit(DeleteCartItemLoadingState());
    try {
      final response = await CartRepo.deleteCartItem(
        userId: event.userId,
        itemId: event.itemId,
        type: event.type,
      );
      emit(DeleteCartItemSuccessState(deleteResponse: response));
      add(FetchCartEvent(userId: event.userId));
    } catch (e) {
      emit(DeleteCartItemErrorState(message: e.toString()));
    }
  }

  Future<void> _onCheckCoupon(
      CheckCouponEvent event, Emitter<CartState> emit) async {
    emit(CheckCouponLoadingState());
    try {
      final response = await CartRepo.checkCoupon(
        couponName: event.couponName,
      );
      emit(CheckCouponSuccessState(couponResponse: response));
    } catch (e) {
      emit(CheckCouponErrorState(message: e.toString()));
    }
  }
}
