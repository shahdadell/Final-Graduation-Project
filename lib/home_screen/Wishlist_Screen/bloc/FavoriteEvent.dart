class FavoriteEvent {}

class AddToFavoriteEvent extends FavoriteEvent {
  final int userId;
  final int itemId;

  AddToFavoriteEvent({
    required this.userId,
    required this.itemId,
  });
}

class FetchFavoriteEvent extends FavoriteEvent {
  final int userId;

  FetchFavoriteEvent({required this.userId});
}

class DeleteFavoriteItemEvent extends FavoriteEvent {
  final int userId;
  final int itemId;

  DeleteFavoriteItemEvent({
    required this.userId,
    required this.itemId,
  });
}

class CheckFavoriteStatusEvent extends FavoriteEvent {
  final int userId;
  final int itemId;

  CheckFavoriteStatusEvent({
    required this.userId,
    required this.itemId,
  });
}
