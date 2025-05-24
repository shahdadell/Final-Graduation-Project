class Datacart {
  String? cartId;
  String? cartUsersid;
  String? cartItemsid;
  String? cartOrders;
  String? cartQuantity;
  String? cartType;
  String? name;
  String? itemsName;
  String? price;
  String? itemsPrice;
  String? image;
  String? itemsImage;
  String? catId;
  String? itemsCat;
  String? discount;
  String? itemsDiscount;
  String? categoriesId;
  String? categoriesName;
  String? categoriesNameAr;
  String? totalPrice;

  Datacart({
    this.cartId,
    this.cartUsersid,
    this.cartItemsid,
    this.cartOrders,
    this.cartQuantity,
    this.cartType,
    this.name,
    this.itemsName,
    this.price,
    this.itemsPrice,
    this.image,
    this.itemsImage,
    this.catId,
    this.itemsCat,
    this.discount,
    this.itemsDiscount,
    this.categoriesId,
    this.categoriesName,
    this.categoriesNameAr,
    this.totalPrice,
  });

  Datacart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id']?.toString();
    cartUsersid = json['cart_usersid']?.toString();
    cartItemsid = json['cart_itemsid']?.toString();
    cartOrders = json['cart_orders']?.toString();
    cartQuantity = json['cart_quantity']?.toString();
    cartType = json['cart_type']?.toString();
    name = json['name']?.toString();
    itemsName = json['items_name']?.toString();
    price = json['price']?.toString();
    itemsPrice = json['items_price']?.toString();
    image = json['image']?.toString();
    itemsImage = json['items_image']?.toString();
    catId = json['cat_id']?.toString();
    itemsCat = json['items_cat']?.toString();
    discount = json['discount']?.toString();
    itemsDiscount = json['items_discount']?.toString();
    categoriesId = json['categories_id']?.toString();
    categoriesName = json['categories_name']?.toString();
    categoriesNameAr = json['categories_name_ar']?.toString();
    totalPrice = json['total_price']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['cart_usersid'] = cartUsersid;
    data['cart_itemsid'] = cartItemsid;
    data['cart_orders'] = cartOrders;
    data['cart_quantity'] = cartQuantity;
    data['cart_type'] = cartType;
    data['name'] = name;
    data['items_name'] = itemsName;
    data['price'] = price;
    data['items_price'] = itemsPrice;
    data['image'] = image;
    data['items_image'] = itemsImage;
    data['cat_id'] = catId;
    data['items_cat'] = itemsCat;
    data['discount'] = discount;
    data['items_discount'] = itemsDiscount;
    data['categories_id'] = categoriesId;
    data['categories_name'] = categoriesName;
    data['categories_name_ar'] = categoriesNameAr;
    data['total_price'] = totalPrice;
    return data;
  }
}
