class AppEndpoints {
  //baseUrl
  static const String baseUrl = "https://abdulrahmanantar.com/outbye/";

  //auth
  static const String register = "auth/signup.php";
  static const String login = "auth/login_app.php";
  static const String logout = 'auth/logout.php';
  static const String refreshToken = 'auth/refresh_token.php';

  //Home
  static const String fetchHome = "home.php";
  static const String offersSlider = "offers.php";
  static const String topSelling = "topselling.php";

  //Services
  static const String fetchService = "services/services.php";

  //Items
  static const String fetchItems = "items/items.php";

  //Cart
  static const String addToCart = "cart/add.php";
  static const String cartCount = "cart/getcountitems.php";
  static const String viewCart = "cart/view.php";
  static const String cartDelete = "cart/delet.php";

  //Favourite
  static const String addToFavourite = "favorite/add.php";
  static const String viewFavourite = "favorite/view.php";
  static const String deleteFromFavouritebyId =
      "favorite/deletefromfavroite.php";
  static const String removeFavourite = "favorite/remove.php";

  //Profile
  static const String profileView = "profile/view.php";
  static const String profileEdite = "profile/edit_profile.php";

  //Search
  static const String search = "items/search.php";

  //Addresses
  static const String addAddress = 'address/add.php';
  static const String viewAddresses = 'address/view.php';
  static const String deleteAddress = 'address/delet.php';
  static const String editAddress = 'address/edit.php';

  //Notification
  static const String greetingNewUser = 'test.php';
  static const String ordersNotifications = 'notification.php';

  // Orders
  static const String checkout = "orders/checkout.php";
  static const String pendingOrders = "orders/pending.php";
  static const String archivedOrders = "orders/archive.php";
  static const String deleteOrder = "orders/delete.php";
  static const String orderDetails = "orders/details.php";

  static const String checkCoupon =
      '/coupon/checkcoupon.php'; // حذفنا /outbye عشان منع التكرار
}
