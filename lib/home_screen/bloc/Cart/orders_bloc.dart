import 'package:bloc/bloc.dart';
import '../../data/repo/orders_repo.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepo orderRepo;

  OrderBloc({required this.orderRepo}) : super(OrderInitialState()) {
    on<CheckoutEvent>(_onCheckout);
    on<FetchPendingOrdersEvent>(_onFetchPendingOrders);
    on<FetchArchivedOrdersEvent>(_onFetchArchivedOrders);
    on<FetchOrderDetailsEvent>(_onFetchOrderDetails);
    on<ArchiveOrderEvent>(_onArchiveOrder);
    on<DeleteOrderEvent>(_onDeleteOrder);
  }

  Future<void> _onCheckout(
      CheckoutEvent event, Emitter<OrderState> emit) async {
    emit(CheckoutLoadingState());
    try {
      final response = await OrderRepo.checkout(
        userId: event.userId,
        addressId: event.addressId,
        orderstype: event.orderstype,
        priceDelivery: event.priceDelivery,
        ordersPrice: event.ordersPrice,
        couponId: event.couponId,
        paymentMethod: event.paymentMethod,
        couponDiscount: event.couponDiscount,
      );
      emit(CheckoutSuccessState(checkoutResponse: response));
    } catch (e) {
      emit(CheckoutErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchPendingOrders(
      FetchPendingOrdersEvent event, Emitter<OrderState> emit) async {
    emit(FetchPendingOrdersLoadingState());
    try {
      final response = await orderRepo.fetchPendingOrders(event.userId);
      emit(FetchPendingOrdersSuccessState(pendingResponse: response));
    } catch (e) {
      emit(FetchPendingOrdersErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchArchivedOrders(
      FetchArchivedOrdersEvent event, Emitter<OrderState> emit) async {
    emit(FetchArchivedOrdersLoadingState());
    try {
      final response = await orderRepo.fetchArchivedOrders(event.userId);
      emit(FetchArchivedOrdersSuccessState(archivedResponse: response));
    } catch (e) {
      emit(FetchArchivedOrdersErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchOrderDetails(
      FetchOrderDetailsEvent event, Emitter<OrderState> emit) async {
    emit(FetchOrderDetailsLoadingState());
    try {
      final response = await orderRepo.fetchOrderDetails(event.ordersId);
      emit(FetchOrderDetailsSuccessState(detailsResponse: response));
    } catch (e) {
      emit(FetchOrderDetailsErrorState(message: e.toString()));
    }
  }

  Future<void> _onArchiveOrder(
      ArchiveOrderEvent event, Emitter<OrderState> emit) async {
    emit(ArchiveOrderLoadingState());
    try {
      await orderRepo.archiveOrder(event.orderId);
      emit(ArchiveOrderSuccessState(message: 'Order archived successfully'));
      add(FetchPendingOrdersEvent(userId: event.userId));
      add(FetchArchivedOrdersEvent(userId: event.userId));
    } catch (e) {
      emit(ArchiveOrderErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteOrder(
      DeleteOrderEvent event, Emitter<OrderState> emit) async {
    emit(DeleteOrderLoadingState());
    try {
      final response = await orderRepo.deleteOrder(event.orderId);
      if (response.status == 'success') {
        emit(DeleteOrderSuccessState(message: 'Order deleted successfully'));
        // Refresh both Pending and Archived Orders to ensure UI updates
        add(FetchPendingOrdersEvent(userId: event.userId));
        add(FetchArchivedOrdersEvent(userId: event.userId));
      } else {
        emit(DeleteOrderErrorState(message: 'Failed to delete order'));
      }
    } catch (e) {
      emit(DeleteOrderErrorState(message: e.toString()));
    }
  }
}
