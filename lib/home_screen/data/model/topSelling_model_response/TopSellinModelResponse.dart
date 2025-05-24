library;

class TopSellingModelResponse {
  TopSellingModelResponse({
    this.status,
    this.items,
  });

  TopSellingModelResponse.fromJson(dynamic json) {
    status = json['status'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
  }
  String? status;
  Items? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (items != null) {
      map['items'] = items?.toJson();
    }
    return map;
  }
}

/// status : "success"
/// data : [{"countitems":"26","cart_id":"222","cart_usersid":"136","cart_itemsid":"56","cart_orders":"24","cart_quantity":"1","items_id":"56","service_id":"1","items_name":"Mixed Grill Platter","items_name_ar":"طبق مشاوي مشكل","items_des":"A platter of mixed grilled meats including kofta, chicken, and lamb chops.","items_des_ar":"طبق مشاوي مشكل يحتوي على كفتة، دجاج، وقطع لحم ضأن.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/mixed girral .jpg","items_count":"25","items_active":"1","items_price":"180","items_discount":"10","items_date":"2025-02-13 19:59:57","items_cat":"4","itemspricedisount":"162"},{"countitems":"25","cart_id":"121","cart_usersid":"120","cart_itemsid":"2","cart_orders":"5","cart_quantity":"12","items_id":"2","service_id":"1","items_name":"Grilled Chicken Sandwich","items_name_ar":"ساندويتش دجاج مشوي","items_des":"A grilled chicken sandwich with fresh vegetables and special sauce.","items_des_ar":"ساندويتش دجاج مشوي مع خضروات طازجة وصلصة خاصة.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/grilled chicken sandwich.png","items_count":"30","items_active":"1","items_price":"50","items_discount":"70","items_date":"2025-01-26 04:00:00","items_cat":"4","itemspricedisount":"15"},{"countitems":"14","cart_id":"144","cart_usersid":"127","cart_itemsid":"1","cart_orders":"1","cart_quantity":"6","items_id":"1","service_id":"1","items_name":"Fried Chicken Meal","items_name_ar":"وجبة دجاج مقلي","items_des":"A delicious meal of fried chicken served with rice or fries, salad, and a drink.","items_des_ar":"وجبة لذيذة من الدجاج المقلي تقدم مع الأرز أو البطاطس المقلية، سلطة، ومشروب.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/fried chicken meal.jpeg","items_count":"50","items_active":"1","items_price":"120","items_discount":"75","items_date":"2025-01-26 04:00:00","items_cat":"4","itemspricedisount":"30"},{"countitems":"8","cart_id":"228","cart_usersid":"150","cart_itemsid":"58","cart_orders":"28","cart_quantity":"1","items_id":"58","service_id":"1","items_name":"Vegetarian Pizza","items_name_ar":"بيتزا نباتية","items_des":"A pizza topped with fresh vegetables and mozzarella cheese.","items_des_ar":"بيتزا مغطاة بالخضروات الطازجة وجبنة الموزاريلا.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/-veggie-pizza-f-2.jpg","items_count":"30","items_active":"1","items_price":"90","items_discount":"15","items_date":"2025-02-13 19:59:57","items_cat":"4","itemspricedisount":"76.5"},{"countitems":"6","cart_id":"116","cart_usersid":"120","cart_itemsid":"3","cart_orders":"2","cart_quantity":"7","items_id":"3","service_id":"15","items_name":"Cappuccino","items_name_ar":"كابتشينو","items_des":"A classic cappuccino made with freshly brewed espresso and steamed milk.","items_des_ar":"كابتشينو كلاسيكي مصنوع من الإسبريسو الطازج والحليب المبخر.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/cappuccino.jpeg","items_count":"100","items_active":"1","items_price":"25","items_discount":"25","items_date":"2025-01-26 04:00:00","items_cat":"5","itemspricedisount":"18.75"},{"countitems":"4","cart_id":"132","cart_usersid":"126","cart_itemsid":"31","cart_orders":"2","cart_quantity":"7","items_id":"31","service_id":"10","items_name":"Pepperoni Pizza","items_name_ar":"بيتزا بيبروني","items_des":"A classic pizza with pepperoni and mozzarella cheese.","items_des_ar":"بيتزا كلاسيكية مع بيبروني وجبنة موزاريلا.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/pepperoni pizza.jpg","items_count":"40","items_active":"1","items_price":"120","items_discount":"35","items_date":"2025-01-26 04:00:00","items_cat":"4","itemspricedisount":"78"},{"countitems":"4","cart_id":"117","cart_usersid":"120","cart_itemsid":"4","cart_orders":"2","cart_quantity":"3","items_id":"4","service_id":"15","items_name":"Chocolate Cake","items_name_ar":"كعكة الشوكولاتة","items_des":"A rich and moist chocolate cake topped with chocolate ganache.","items_des_ar":"كعكة شوكولاتة غنية ورطبة مغطاة بصوص الشوكولاتة.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/chocolate_cake.jpg","items_count":"20","items_active":"1","items_price":"60","items_discount":"25","items_date":"2025-01-26 04:00:00","items_cat":"5","itemspricedisount":"45"},{"countitems":"2","cart_id":"127","cart_usersid":"120","cart_itemsid":"42","cart_orders":"2","cart_quantity":"8","items_id":"42","service_id":"21","items_name":"Sunset Cruise","items_name_ar":"رحلة غروب الشمس","items_des":"A romantic sunset cruise on Lake Qarun with refreshments.","items_des_ar":"رحلة غروب الشمس الرومانسية على بحيرة قارون مع مشروبات منعشة.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/sunset cruise.jpeg","items_count":"10","items_active":"1","items_price":"500","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"7","itemspricedisount":"500"},{"countitems":"2","cart_id":"125","cart_usersid":"120","cart_itemsid":"36","cart_orders":"2","cart_quantity":"7","items_id":"36","service_id":"14","items_name":"Eco-Friendly Stay","items_name_ar":"إقامة صديقة للبيئة","items_des":"A stay in an eco-friendly lodge with rustic charm and modern comforts.","items_des_ar":"إقامة في لودج صديق للبيئة يتميز بسحر ريفي ووسائل راحة حديثة.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/eco-fridly stay .jpg","items_count":"10","items_active":"1","items_price":"800","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"6","itemspricedisount":"800"},{"countitems":"2","cart_id":"119","cart_usersid":"120","cart_itemsid":"39","cart_orders":"7","cart_quantity":"17","items_id":"39","service_id":"18","items_name":"Dark Roast Coffee","items_name_ar":"قهوة داكنة","items_des":"A strong dark roast coffee for true coffee lovers.","items_des_ar":"قهوة داكنة قوية لعشاق القهوة الحقيقية.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/dark cohhe.webp","items_count":"40","items_active":"1","items_price":"30","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"5","itemspricedisount":"30"},{"countitems":"2","cart_id":"118","cart_usersid":"120","cart_itemsid":"40","cart_orders":"13","cart_quantity":"23","items_id":"40","service_id":"18","items_name":"Chocolate Brownie","items_name_ar":"براوني شوكولاتة","items_des":"A rich chocolate brownie with a gooey center.","items_des_ar":"براوني شوكولاتة غني بمركز لذيذ.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/chocolate browni .webp","items_count":"25","items_active":"1","items_price":"40","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"5","itemspricedisount":"40"},{"countitems":"2","cart_id":"124","cart_usersid":"120","cart_itemsid":"22","cart_orders":"2","cart_quantity":"7","items_id":"22","service_id":"12","items_name":"Romantic Dinner","items_name_ar":"عشاء رومانسي","items_des":"A romantic dinner for two with a view of Lake Qarun, including a three-course meal.","items_des_ar":"عشاء رومانسي لشخصين بإطلالة على بحيرة قارون، يتضمن وجبة من ثلاث أطباق.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/romantic-table-arrangement.webp","items_count":"10","items_active":"1","items_price":"700","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"6","itemspricedisount":"700"},{"countitems":"2","cart_id":"128","cart_usersid":"120","cart_itemsid":"41","cart_orders":"2","cart_quantity":"10","items_id":"41","service_id":"21","items_name":"Fishing Trip","items_name_ar":"رحلة صيد","items_des":"A guided fishing trip on Lake Qarun with all equipment provided.","items_des_ar":"رحلة صيد مرشدة على بحيرة قارون مع توفير جميع المعدات.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/fishing trip.jpeg","items_count":"15","items_active":"1","items_price":"400","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"7","itemspricedisount":"400"},{"countitems":"2","cart_id":"126","cart_usersid":"120","cart_itemsid":"35","cart_orders":"2","cart_quantity":"7","items_id":"35","service_id":"14","items_name":"Horseback Riding","items_name_ar":"ركوب الخيل","items_des":"A horseback riding experience through the scenic landscapes of Tunis Village.","items_des_ar":"تجربة ركوب الخيل عبر المناظر الطبيعية الخلابة لقرية تونس.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/horseback riding.jpg","items_count":"15","items_active":"1","items_price":"300","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"6","itemspricedisount":"300"},{"countitems":"1","cart_id":"207","cart_usersid":"120","cart_itemsid":"155","cart_orders":"25","cart_quantity":"2","items_id":"155","service_id":"21","items_name":"Boat Tour","items_name_ar":"جولة بالقارب","items_des":"A relaxing boat tour on Lake Qarun.","items_des_ar":"جولة بالقارب على بحيرة قارون.","items_image":"https://example.com/boat_tour.jpg","items_count":"20","items_active":"1","items_price":"250","items_discount":"0","items_date":"2025-02-13 22:02:16","items_cat":"7","itemspricedisount":"250"},{"countitems":"1","cart_id":"212","cart_usersid":"120","cart_itemsid":"19","cart_orders":"25","cart_quantity":"1","items_id":"19","service_id":"16","items_name":"Margherita Pizza","items_name_ar":"بيتزا مارغريتا","items_des":"A classic pizza with tomato sauce, mozzarella cheese, and fresh basil.","items_des_ar":"بيتزا كلاسيكية مع صلصة الطماطم، جبنة موزاريلا، وريحان طازج.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/PIZZA-MARGHERITA.jpg","items_count":"30","items_active":"1","items_price":"100","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"5","itemspricedisount":"100"},{"countitems":"1","cart_id":"123","cart_usersid":"120","cart_itemsid":"32","cart_orders":"2","cart_quantity":"7","items_id":"32","service_id":"10","items_name":"Chicken Shawarma","items_name_ar":"شاورما دجاج","items_des":"A wrap filled with grilled chicken, garlic sauce, and pickles.","items_des_ar":"لفة محشوة بدجاج مشوي، صلصة ثوم، ومخلل.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/shawarma sandeich .jpg","items_count":"30","items_active":"1","items_price":"40","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"4","itemspricedisount":"40"},{"countitems":"1","cart_id":"152","cart_usersid":"127","cart_itemsid":"5","cart_orders":"8","cart_quantity":"5","items_id":"5","service_id":"11","items_name":"Deluxe Room","items_name_ar":"غرفة ديلوكس","items_des":"A spacious deluxe room with a view of Lake Qarun, equipped with modern amenities.","items_des_ar":"غرفة ديلوكس واسعة بإطلالة على بحيرة قارون، مجهزة بوسائل الراحة الحديثة.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/deluxe room.jpg","items_count":"10","items_active":"1","items_price":"1500","items_discount":"35","items_date":"2025-01-26 04:00:00","items_cat":"6","itemspricedisount":"975"},{"countitems":"1","cart_id":"210","cart_usersid":"120","cart_itemsid":"158","cart_orders":"25","cart_quantity":"1","items_id":"158","service_id":"21","items_name":"Bird Watching","items_name_ar":"مراقبة الطيور","items_des":"A guided tour to observe the bird species around the lake.","items_des_ar":"جولة مرشدة لمراقبة أنواع الطيور حول البحيرة.","items_image":"https://example.com/bird_watching.jpg","items_count":"15","items_active":"1","items_price":"200","items_discount":"0","items_date":"2025-02-13 22:02:16","items_cat":"7","itemspricedisount":"200"},{"countitems":"1","cart_id":"154","cart_usersid":"127","cart_itemsid":"21","cart_orders":"12","cart_quantity":"4","items_id":"21","service_id":"12","items_name":"Spa Package","items_name_ar":"باقة سبا","items_des":"A relaxing spa package including a massage, facial, and access to the sauna.","items_des_ar":"باقة سبا مريحة تشمل تدليك، عناية بالبشرة، واستخدام الساونا.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/spa_package.jpg","items_count":"15","items_active":"1","items_price":"500","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"6","itemspricedisount":"500"},{"countitems":"1","cart_id":"157","cart_usersid":"127","cart_itemsid":"33","cart_orders":"11","cart_quantity":"5","items_id":"33","service_id":"13","items_name":"Lakeside Suite","items_name_ar":"جناح البحيرة","items_des":"A luxurious suite with a view of Lake Qarun, equipped with modern amenities.","items_des_ar":"جناح فاخر بإطلالة على بحيرة قارون، مجهز بوسائل الراحة الحديثة.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/lakeaside suit.jpg","items_count":"10","items_active":"1","items_price":"1200","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"6","itemspricedisount":"1200"},{"countitems":"1","cart_id":"153","cart_usersid":"127","cart_itemsid":"6","cart_orders":"8","cart_quantity":"5","items_id":"6","service_id":"11","items_name":"Breakfast Buffet","items_name_ar":"بوفيه الإفطار","items_des":"A rich breakfast buffet with a variety of local and international dishes.","items_des_ar":"بوفيه إفطار غني بمجموعة متنوعة من الأطباق المحلية والعالمية.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/breakfast buffet.jpg","items_count":"50","items_active":"1","items_price":"200","items_discount":"55","items_date":"2025-01-26 04:00:00","items_cat":"6","itemspricedisount":"90"},{"countitems":"1","cart_id":"129","cart_usersid":"126","cart_itemsid":"61","cart_orders":"2","cart_quantity":"4","items_id":"61","service_id":"2","items_name":"Chicken Popcorn","items_name_ar":"بوب كورن دجاج","items_des":"Crispy chicken popcorn pieces, perfect for sharing.","items_des_ar":"قطع دجاج مقرمشة، مثالية للمشاركة.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/chicken popcorn.jpg","items_count":"50","items_active":"1","items_price":"50","items_discount":"0","items_date":"2025-02-13 19:59:58","items_cat":"4","itemspricedisount":"50"},{"countitems":"1","cart_id":"156","cart_usersid":"127","cart_itemsid":"34","cart_orders":"11","cart_quantity":"6","items_id":"34","service_id":"13","items_name":"Boat Tour","items_name_ar":"جولة بالقارب","items_des":"A relaxing boat tour on Lake Qarun with stunning views.","items_des_ar":"جولة بالقارب على بحيرة قارون مع إطلالات خلابة.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/boat Tour .jpg","items_count":"20","items_active":"1","items_price":"250","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"6","itemspricedisount":"250"},{"countitems":"1","cart_id":"164","cart_usersid":"120","cart_itemsid":"7","cart_orders":"9","cart_quantity":"1","items_id":"7","service_id":"19","items_name":"Guided Safari Tour","items_name_ar":"جولة سفاري مرشدة","items_des":"A guided safari tour through the stunning landscapes of Wadi El-Rayan.","items_des_ar":"جولة سفاري مرشدة عبر المناظر الطبيعية الخلابة لوادي الريان.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/safari_tour.jpg","items_count":"20","items_active":"1","items_price":"500","items_discount":"30","items_date":"2025-01-26 04:00:00","items_cat":"7","itemspricedisount":"350"},{"countitems":"1","cart_id":"161","cart_usersid":"127","cart_itemsid":"24","cart_orders":"8","cart_quantity":"5","items_id":"24","service_id":"20","items_name":"Desert Camping","items_name_ar":"تخييم صحراوي","items_des":"An overnight camping experience in the desert with a bonfire and stargazing.","items_des_ar":"تجربة تخييم ليلية في الصحراء مع إشعال النار ورؤية النجوم.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/desert camping .jpg","items_count":"20","items_active":"1","items_price":"400","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"7","itemspricedisount":"400"},{"countitems":"1","cart_id":"217","cart_usersid":"120","cart_itemsid":"63","cart_orders":"25","cart_quantity":"1","items_id":"63","service_id":"2","items_name":"Chicken Strips Meal","items_name_ar":"وجبة شرائح دجاج","items_des":"A meal of crispy chicken strips served with fries and a drink.","items_des_ar":"وجبة شرائح دجاج مقرمشة تقدم مع البطاطس والمشروب.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/chichen stripsmeal .jpg","items_count":"35","items_active":"1","items_price":"80","items_discount":"0","items_date":"2025-02-13 19:59:58","items_cat":"4","itemspricedisount":"80"},{"countitems":"1","cart_id":"283","cart_usersid":"165","cart_itemsid":"10","cart_orders":"74","cart_quantity":"8","items_id":"10","service_id":"5","items_name":"Small Koshary","items_name_ar":"كشري صغير","items_des":"A small portion of the traditional Egyptian koshary, perfect for a quick meal.","items_des_ar":"وجبة صغيرة من الكشري المصري التقليدي، مثالية لوجبة سريعة.","items_image":"https://abdulrahmanantar.com/outbye/upload/items/small koshary.jpeg","items_count":"60","items_active":"1","items_price":"25","items_discount":"0","items_date":"2025-01-26 04:00:00","items_cat":"4","itemspricedisount":"25"}]

class Items {
  Items({
    this.status,
    this.data,
  });

  Items.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TopSellingData.fromJson(v));
      });
    }
  }
  String? status;
  List<TopSellingData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// countitems : "26"
/// cart_id : "222"
/// cart_usersid : "136"
/// cart_itemsid : "56"
/// cart_orders : "24"
/// cart_quantity : "1"
/// items_id : "56"
/// service_id : "1"
/// items_name : "Mixed Grill Platter"
/// items_name_ar : "طبق مشاوي مشكل"
/// items_des : "A platter of mixed grilled meats including kofta, chicken, and lamb chops."
/// items_des_ar : "طبق مشاوي مشكل يحتوي على كفتة، دجاج، وقطع لحم ضأن."
/// items_image : "https://abdulrahmanantar.com/outbye/upload/items/mixed girral .jpg"
/// items_count : "25"
/// items_active : "1"
/// items_price : "180"
/// items_discount : "10"
/// items_date : "2025-02-13 19:59:57"
/// items_cat : "4"
/// itemspricedisount : "162"

class TopSellingData {
  TopSellingData({
    this.countitems,
    this.cartId,
    this.cartUsersid,
    this.cartItemsid,
    this.cartOrders,
    this.cartQuantity,
    this.itemsId,
    this.serviceId,
    this.itemsName,
    this.itemsNameAr,
    this.itemsDes,
    this.itemsDesAr,
    this.itemsImage,
    this.itemsCount,
    this.itemsActive,
    this.itemsPrice,
    this.itemsDiscount,
    this.itemsDate,
    this.itemsCat,
    this.itemspricedisount,
  });

  TopSellingData.fromJson(dynamic json) {
    countitems = json['countitems'];
    cartId = json['cart_id'];
    cartUsersid = json['cart_usersid'];
    cartItemsid = json['cart_itemsid'];
    cartOrders = json['cart_orders'];
    cartQuantity = json['cart_quantity'];
    itemsId = json['items_id'];
    serviceId = json['service_id'];
    itemsName = json['items_name'];
    itemsNameAr = json['items_name_ar'];
    itemsDes = json['items_des'];
    itemsDesAr = json['items_des_ar'];
    itemsImage = json['items_image'];
    itemsCount = json['items_count'];
    itemsActive = json['items_active'];
    itemsPrice = json['items_price'];
    itemsDiscount = json['items_discount'];
    itemsDate = json['items_date'];
    itemsCat = json['items_cat'];
    itemspricedisount = json['itemspricedisount'];
  }
  String? countitems;
  String? cartId;
  String? cartUsersid;
  String? cartItemsid;
  String? cartOrders;
  String? cartQuantity;
  String? itemsId;
  String? serviceId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDes;
  String? itemsDesAr;
  String? itemsImage;
  String? itemsCount;
  String? itemsActive;
  String? itemsPrice;
  String? itemsDiscount;
  String? itemsDate;
  String? itemsCat;
  String? itemspricedisount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['countitems'] = countitems;
    map['cart_id'] = cartId;
    map['cart_usersid'] = cartUsersid;
    map['cart_itemsid'] = cartItemsid;
    map['cart_orders'] = cartOrders;
    map['cart_quantity'] = cartQuantity;
    map['items_id'] = itemsId;
    map['service_id'] = serviceId;
    map['items_name'] = itemsName;
    map['items_name_ar'] = itemsNameAr;
    map['items_des'] = itemsDes;
    map['items_des_ar'] = itemsDesAr;
    map['items_image'] = itemsImage;
    map['items_count'] = itemsCount;
    map['items_active'] = itemsActive;
    map['items_price'] = itemsPrice;
    map['items_discount'] = itemsDiscount;
    map['items_date'] = itemsDate;
    map['items_cat'] = itemsCat;
    map['itemspricedisount'] = itemspricedisount;
    return map;
  }
}
