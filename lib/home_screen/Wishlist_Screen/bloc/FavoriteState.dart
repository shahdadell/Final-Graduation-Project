import 'package:graduation_project/home_screen/Wishlist_Screen/data/model/add_to_favourite.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/data/model/delete_from_fav.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/data/model/view_favourite_list.dart';

class FavoriteState {}

class FavoriteInitialState extends FavoriteState {}

class AddToFavoriteLoadingState extends FavoriteState {}

class AddToFavoriteSuccessState extends FavoriteState {
  final AddtoFavourite favoriteResponse;

  AddToFavoriteSuccessState({required this.favoriteResponse});
}

class AddToFavoriteErrorState extends FavoriteState {
  final String message;

  AddToFavoriteErrorState({required this.message});
}

class FetchFavoriteLoadingState extends FavoriteState {}

class FetchFavoriteSuccessState extends FavoriteState {
  final ViewFavouriteList favoriteViewResponse;

  FetchFavoriteSuccessState({required this.favoriteViewResponse});
}

class FetchFavoriteErrorState extends FavoriteState {
  final String message;

  FetchFavoriteErrorState({required this.message});
}

class DeleteFavoriteItemLoadingState extends FavoriteState {
  final int itemId; // إضافة itemId لتحديد العنصر اللي بيحمل

  DeleteFavoriteItemLoadingState({required this.itemId});
}

class DeleteFavoriteItemSuccessState extends FavoriteState {
  final DeleteFromFav deleteResponse;

  DeleteFavoriteItemSuccessState({required this.deleteResponse});
}

class DeleteFavoriteItemErrorState extends FavoriteState {
  final String message;

  DeleteFavoriteItemErrorState({required this.message});
}

class CheckFavoriteStatusLoadingState extends FavoriteState {}

class CheckFavoriteStatusSuccessState extends FavoriteState {
  final int itemId;
  final bool isFavorite;

  CheckFavoriteStatusSuccessState({
    required this.itemId,
    required this.isFavorite,
  });
}

class CheckFavoriteStatusErrorState extends FavoriteState {
  final String message;

  CheckFavoriteStatusErrorState({required this.message});
}