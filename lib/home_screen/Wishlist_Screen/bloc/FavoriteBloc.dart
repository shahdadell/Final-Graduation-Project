import 'package:bloc/bloc.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteEvent.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteState.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/data/repo/FavoriteRepo.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepo favoriteRepo;

  FavoriteBloc({required this.favoriteRepo}) : super(FavoriteInitialState()) {
    on<AddToFavoriteEvent>(_onAddToFavorite);
    on<FetchFavoriteEvent>(_onFetchFavorite);
    on<DeleteFavoriteItemEvent>(_onDeleteFavoriteItem);
    on<CheckFavoriteStatusEvent>(_onCheckFavoriteStatus);
  }

  Future<void> _onAddToFavorite(
      AddToFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(AddToFavoriteLoadingState());
    try {
      final response = await FavoriteRepo.addToFavorite(
        userId: event.userId,
        itemId: event.itemId,
      );
      emit(AddToFavoriteSuccessState(favoriteResponse: response));
      // نعيد جلب الـ Favorites عشان نحدّث الـ UI
      add(FetchFavoriteEvent(userId: event.userId));
      // نحدّث حالة الأيقونة
      add(CheckFavoriteStatusEvent(userId: event.userId, itemId: event.itemId));
    } catch (e) {
      emit(AddToFavoriteErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchFavorite(
      FetchFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(FetchFavoriteLoadingState());
    try {
      final response = await FavoriteRepo.fetchFavorite(userId: event.userId);
      emit(FetchFavoriteSuccessState(favoriteViewResponse: response));
    } catch (e) {
      emit(FetchFavoriteErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteFavoriteItem(
      DeleteFavoriteItemEvent event, Emitter<FavoriteState> emit) async {
    emit(DeleteFavoriteItemLoadingState(itemId: event.itemId)); // تعديل هنا
    try {
      final response = await FavoriteRepo.deleteFavoriteItem(
        userId: event.userId,
        itemId: event.itemId,
      );
      emit(DeleteFavoriteItemSuccessState(deleteResponse: response));
      // نعيد جلب الـ Favorites عشان نحدّث الـ UI
      add(FetchFavoriteEvent(userId: event.userId));
      // نحدّث حالة الأيقونة
      add(CheckFavoriteStatusEvent(userId: event.userId, itemId: event.itemId));
    } catch (e) {
      emit(DeleteFavoriteItemErrorState(message: e.toString()));
    }
  }

  Future<void> _onCheckFavoriteStatus(
      CheckFavoriteStatusEvent event, Emitter<FavoriteState> emit) async {
    emit(CheckFavoriteStatusLoadingState());
    try {
      final isFavorite = await FavoriteRepo.checkFavoriteStatus(
        userId: event.userId,
        itemId: event.itemId,
      );
      emit(CheckFavoriteStatusSuccessState(
          itemId: event.itemId, isFavorite: isFavorite));
    } catch (e) {
      emit(CheckFavoriteStatusErrorState(message: e.toString()));
    }
  }
}