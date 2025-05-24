import 'package:graduation_project/App_Images/app_images.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

// String userName = "Menna Hosny Ali"; // التعليق ده موجود عندك وهنسيبه كده
// String? username = AppLocalStorage.getData(AppLocalStorage.userNameKey) as String?;

Future<String?> getUsername() async {
  return AppLocalStorage.getData(AppLocalStorage.userNameKey) as String?;
}

String getGreetingMessage() {
  int hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) return "Good Morning";
  if (hour >= 12 && hour < 17) return "Good Afternoon";
  if (hour >= 17 && hour < 21) return "Good Evening";
  return "Good Night";
}

int currentindex = 0;

List<TextAndImageClass> categories = [
  TextAndImageClass(icon: AppImages.restaurant, name: "Restaurants"),
  TextAndImageClass(icon: AppImages.coffeehouse, name: "Coffee"),
  TextAndImageClass(icon: AppImages.tour, name: "Tourism places"),
  TextAndImageClass(icon: AppImages.hotel, name: "Hotel"),
];

// List<CardClass> Row1 = [
//   CardClass(
//       destination: "1.5 km",
//       image: AppImages.vegetablesimage,
//       name: "Pizza Hut",
//       rate: "4.8",
//       discount: "4% off your order"),
//   CardClass(
//       destination: "1.5 km",
//       image: AppImages.knifeburger,
//       name: "Pizza Hut",
//       rate: "4.8",
//       discount: "4% off your order"),
// ];

// List<CardClass> Row2 = [
//   CardClass(
//       destination: "1.5 km",
//       image: AppImages.burger,
//       name: "Pizza Hut",
//       rate: "4.8",
//       discount: "4% off your order"),
//   CardClass(
//       destination: "1.5 km",
//       image: AppImages.pizza,
//       name: "Pizza Hut",
//       rate: "4.8",
//       discount: "4% off your order"),
// ];

// List<CardClass> Row3 = [
//   CardClass(
//       destination: "1.5 km",
//       image: AppImages.food,
//       name: "Pizza",
//       rate: "4.8",
//       discount: "4% off your order"),
//   CardClass(
//       destination: "1.5 km",
//       image: AppImages.food2,
//       name: "Pizza",
//       rate: "4.8",
//       discount: "4% off your order"),
// ];

// List<TextAndImageClass> dishes = [
//   TextAndImageClass(
//       icon: AppImages.seafood, name: "Áp dụng 02 voucher mỗi đơn "),
//   TextAndImageClass(icon: AppImages.meet, name: "Áp dụng 02 voucher mỗi đơn "),
// ];

// List<RestaurantClass> restaurants = [
//   RestaurantClass(
//       icon: AppImages.restaurantimg,
//       name: "Elisandra Restaurant ",
//       location: "Elisandra Restaurant "),
//   RestaurantClass(
//       icon: AppImages.restaurantimg2,
//       name: "Elisandra Restaurant ",
//       location: "Elisandra Restaurant "),
// ];

// List<CardClass> recommendedList = [
//   CardClass(
//       destination: "1.5 km",
//       image: AppImages.food3,
//       name: "Hamburger",
//       rate: "4.8",
//       discount: "4% off your order"),
//   CardClass(
//       destination: "1.5 km",
//       image: AppImages.food4,
//       name: "Hamburger",
//       rate: "4.8",
//       discount: "4% off your order"),
//   CardClass(
//       destination: "1.5 km",
//       image: AppImages.food5,
//       name: "Hamburger",
//       rate: "4.8",
//       discount: "4% off your order"),
// ];

class TextAndImageClass {
  String? name;
  String? icon;
  TextAndImageClass({required this.icon, required this.name});
}

class RestaurantClass {
  String? name;
  String? icon;
  String? location;
  RestaurantClass({
    required this.icon,
    required this.name,
    required this.location,
  });
}

class CardClass {
  String? destination;
  String? image;
  String? name;
  String? rate;
  String? discount;
  CardClass({
    required this.destination,
    required this.image,
    required this.name,
    required this.rate,
    required this.discount,
  });
}
