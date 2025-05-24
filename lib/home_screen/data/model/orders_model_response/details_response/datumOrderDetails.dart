class Datumorderdetails {
  String? itemsPrice;
  String? countItems;
  String? cartId;
  String? cartUsersId;
  String? cartItemsId;
  String? cartOrders;
  String? cartQuantity;
  String? cartType;
  String? name;
  String? image;
  String? catId;

  Datumorderdetails({
    this.itemsPrice,
    this.countItems,
    this.cartId,
    this.cartUsersId,
    this.cartItemsId,
    this.cartOrders,
    this.cartQuantity,
    this.cartType,
    this.name,
    this.image,
    this.catId,
  });

  factory Datumorderdetails.fromJson(Map<String, dynamic> json) =>
      Datumorderdetails(
        itemsPrice: json['itemsprice'] as String?,
        countItems: json['countitems'] as String?,
        cartId: json['cart_id'] as String?,
        cartUsersId: json['cart_usersid'] as String?,
        cartItemsId: json['cart_itemsid'] as String?,
        cartOrders: json['cart_orders'] as String?,
        cartQuantity: json['cart_quantity'] as String?,
        cartType: json['cart_type'] as String?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        catId: json['cat_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'itemsprice': itemsPrice,
        'countitems': countItems,
        'cart_id': cartId,
        'cart_usersid': cartUsersId,
        'cart_itemsid': cartItemsId,
        'cart_orders': cartOrders,
        'cart_quantity': cartQuantity,
        'cart_type': cartType,
        'name': name,
        'image': image,
        'cat_id': catId,
      };
}
