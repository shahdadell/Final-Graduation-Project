import 'package:graduation_project/home_screen/data/model/orders_model_response/details_response/DetailsResponse.dart';

import '../../data/model/orders_model_response/ArchiveResponse.dart';
import '../../data/model/orders_model_response/CheckOutResponse.dart';
import '../../data/model/orders_model_response/PendingResponse.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState {}

class CheckoutLoadingState extends OrderState {}

class CheckoutSuccessState extends OrderState {
  final CheckOutResponse checkoutResponse;

  CheckoutSuccessState({required this.checkoutResponse});
}

class CheckoutErrorState extends OrderState {
  final String message;

  CheckoutErrorState({required this.message});
}

class FetchPendingOrdersLoadingState extends OrderState {}

class FetchPendingOrdersSuccessState extends OrderState {
  final PendingResponse pendingResponse;

  FetchPendingOrdersSuccessState({required this.pendingResponse});
}

class FetchPendingOrdersErrorState extends OrderState {
  final String message;

  FetchPendingOrdersErrorState({required this.message});
}

class FetchArchivedOrdersLoadingState extends OrderState {}

class FetchArchivedOrdersSuccessState extends OrderState {
  final ArchiveResponse archivedResponse;

  FetchArchivedOrdersSuccessState({required this.archivedResponse});
}

class FetchArchivedOrdersErrorState extends OrderState {
  final String message;

  FetchArchivedOrdersErrorState({required this.message});
}

class FetchOrderDetailsLoadingState extends OrderState {}

class FetchOrderDetailsSuccessState extends OrderState {
  final DetailsResponse detailsResponse;

  FetchOrderDetailsSuccessState({required this.detailsResponse});
}

class FetchOrderDetailsErrorState extends OrderState {
  final String message;

  FetchOrderDetailsErrorState({required this.message});
}

class ArchiveOrderLoadingState extends OrderState {}

class ArchiveOrderSuccessState extends OrderState {
  final String message;

  ArchiveOrderSuccessState({required this.message});
}

class ArchiveOrderErrorState extends OrderState {
  final String message;

  ArchiveOrderErrorState({required this.message});
}

class DeleteOrderLoadingState extends OrderState {}

class DeleteOrderSuccessState extends OrderState {
  final String message;

  DeleteOrderSuccessState({required this.message});
}

class DeleteOrderErrorState extends OrderState {
  final String message;

  DeleteOrderErrorState({required this.message});
}
