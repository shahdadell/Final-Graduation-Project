// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/Theme/theme.dart';
// import 'package:graduation_project/app_images/app_images.dart';
// import 'package:graduation_project/home_screen/UI/Home_Page/homevariables.dart';
// import 'package:graduation_project/home_screen/UI/Home_Page/homewidgets.dart';
// import 'package:graduation_project/Theme/style.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class HomeScreen extends StatefulWidget {
//   static const String routName = 'HomeScreen';
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               homeTopBar(),
//               searchField(w),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   "Special offer",
//                   style: Theme.of(context).textTheme.bodyLarge,
//                   // textStyle(20, FontWeight.w700, MyTheme.blackColor),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Stack(
//                   alignment: Alignment.topCenter,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: CarouselSlider.builder(
//                         itemCount: 4,
//                         itemBuilder:
//                             (BuildContext context, int index, int realIndex) {
//                           return carouselSliderImage(AppImages.offerimg);
//                         },
//                         options: CarouselOptions(
//                           initialPage: 0,
//                           viewportFraction: 1,
//                           reverse: false,
//                           autoPlay: true,
//                           autoPlayInterval: const Duration(seconds: 3),
//                           autoPlayAnimationDuration:
//                               const Duration(milliseconds: 800),
//                           scrollDirection: Axis.horizontal,
//                           onPageChanged: (index, reason) {
//                             setState(() {
//                               currentindex = index;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 30),
//                       child: AnimatedSmoothIndicator(
//                         activeIndex: currentindex,
//                         count: 4,
//                         effect: SlideEffect(
//                           activeDotColor: MyTheme.whiteColor,
//                           dotColor: MyTheme.grayColor,
//                           dotWidth: 85,
//                           dotHeight: 4,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GridView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4),
//                 itemCount: categories.length,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   TextAndImageClass item = categories[index];
//                   return InkWell(
//                     overlayColor: WidgetStatePropertyAll(MyTheme.transparent),
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           item.icon!,
//                           height: 48,
//                           width: 48,
//                         ),
//                         Text(
//                           item.name!,
//                           style: textStyle(
//                               14, FontWeight.w600, MyTheme.blackColor),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               horizontalListTitle("Discount guaranteed!"),
//               horizontalList(Row1),
//               Center(
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: 20),
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(16)),
//                   width: 327,
//                   height: 116,
//                   child: Stack(
//                     children: [
//                       Align(
//                           alignment: Alignment.bottomRight,
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(16),
//                               child: Image.asset(AppImages.chicken))),
//                       ClipRRect(
//                           borderRadius: const BorderRadius.horizontal(
//                               left: Radius.circular(16)),
//                           child: Image.asset(AppImages.discovershape)),
//                       Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: 200,
//                               child: Text(
//                                 "Some interesting events of YUMMY FOOD",
//                                 textAlign: TextAlign.start,
//                                 style: textStyle(
//                                   16,
//                                   FontWeight.w700,
//                                   MyTheme.whiteColor,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(top: 5),
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 color: MyTheme.whiteColor,
//                               ),
//                               child: Text(
//                                 "Discover",
//                                 style: textStyle(
//                                     12, FontWeight.w600, MyTheme.blackColor),
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               horizontalListTitle("What's delicious around here?"),
//               horizontalList(Row2),
//               horizontalDishesList(dishes),
//               horizontalListTitle("Highlights of March"),
//               horizontalList(Row3),
//               horizontalListTitle("Nearby Restaurants"),
//               horizontalRestaurantList(restaurants),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   "Recommended For You ",
//                   style: textStyle(20, FontWeight.w700, MyTheme.blackColor),
//                 ),
//               ),
//               recommendedListView(recommendedList)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // import 'package:carousel_slider/carousel_slider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:graduation_project/Theme/theme.dart';
// // import 'package:graduation_project/app_images/app_images.dart';
// // import 'package:graduation_project/home_screen/UI/homewidgets.dart';
// // import 'package:graduation_project/home_screen/UI/homevariables.dart';
// // import 'package:graduation_project/home_screen/bloc/home_bloc.dart';
// // import 'package:graduation_project/home_screen/bloc/home_event.dart';
// // import 'package:graduation_project/home_screen/bloc/home_state.dart';
// // import 'package:graduation_project/home_screen/data/model/home_model_response/home_model_response.dart';
// // import 'package:graduation_project/home_screen/data/repo/home_repo.dart';
// // import 'package:graduation_project/home_screen/style.dart';
// // import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// // class HomeScreen extends StatefulWidget {
// //   static const String routName = 'HomeScreen';
// //   const HomeScreen({super.key});

// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     double w = MediaQuery.of(context).size.width;
// //     return BlocProvider(
// //       create: (context) => HomeBloc()..add(FetchHomeDataEvent(HomeModelResponse())),
// //  // جلب البيانات عند فتح الصفحة
// //       child: Scaffold(
// //         body: SafeArea(
// //           child: SingleChildScrollView(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 homeTopBar(),
// //                 searchField(w),
// //                 Padding(
// //                   padding: const EdgeInsets.only(left: 20),
// //                   child: Text(
// //                     "Special offer",
// //                     style: Theme.of(context).textTheme.bodyLarge,
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.all(15),
// //                   child: Stack(
// //                     alignment: Alignment.topCenter,
// //                     children: [
// //                       ClipRRect(
// //                         borderRadius: BorderRadius.circular(12),
// //                         child: CarouselSlider.builder(
// //                           itemCount: 4,
// //                           itemBuilder:
// //                               (BuildContext context, int index, int realIndex) {
// //                             return carouselSliderImage(AppImages.offerimg);
// //                           },
// //                           options: CarouselOptions(
// //                             initialPage: 0,
// //                             viewportFraction: 1,
// //                             reverse: false,
// //                             autoPlay: true,
// //                             autoPlayInterval: const Duration(seconds: 3),
// //                             autoPlayAnimationDuration:
// //                                 const Duration(milliseconds: 800),
// //                             scrollDirection: Axis.horizontal,
// //                             onPageChanged: (index, reason) {
// //                               setState(() {
// //                                 currentindex = index;
// //                               });
// //                             },
// //                           ),
// //                         ),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.only(top: 30),
// //                         child: AnimatedSmoothIndicator(
// //                           activeIndex: currentindex,
// //                           count: 4,
// //                           effect: SlideEffect(
// //                             activeDotColor: MyTheme.whiteColor,
// //                             dotColor: MyTheme.grayColor,
// //                             dotWidth: 85,
// //                             dotHeight: 4,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 /// 🔹 BlocBuilder لعرض الأقسام (Categories)
// //                 BlocBuilder<HomeBloc, HomeState>(
// //   builder: (context, state) {
// //     if (state is FetchLoadingHomeDataState) {
// //       return const Center(child: CircularProgressIndicator());
// //     } else if (state is FetchSuccessHomeDataState) {
// //       return GridView.builder(
// //         physics: const NeverScrollableScrollPhysics(),
// //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //             crossAxisCount: 4),
// //         itemCount: state.categories.length,
// //         shrinkWrap: true,
// //         itemBuilder: (BuildContext context, int index) {
// //           return InkWell(
// //             overlayColor: WidgetStatePropertyAll(MyTheme.transparent),
// //             onTap: () {},
// //             child: Column(
// //               children: [
// //                 Image.network(
// //                   state.categories[index].categoriesImage ?? '',
// //                   width: 48,
// //                   height: 48,
// //                   fit: BoxFit.cover,
// //                   errorBuilder: (context, error, stackTrace) {
// //                     return const Icon(Icons.broken_image, size: 48);
// //                   },
// //                 ),
// //                 Text(
// //                   state.categories[index].categoriesName ?? 'Unknown',
// //                   style: textStyle(14, FontWeight.w600, MyTheme.blackColor),
// //                 )
// //               ],
// //             ),
// //           );
// //         },
// //       );
// //     } else if (state is HomeErrorState) {
// //       return Center(child: Text("Error: ${state.message}"));
// //     }
// //     return const SizedBox.shrink();
// //   },
// // ),
// //                 // BlocBuilder<HomeBloc, HomeState>(
// //                 //   builder: (context, state) {
// //                 //     if (state is FetchLoadingHomeDataState) {
// //                 //       return Center(child: CircularProgressIndicator());
// //                 //     } else if (state is FetchSuccessHomeDataState) {
// //                 //       return GridView.builder(
// //                 //         physics: const NeverScrollableScrollPhysics(),
// //                 //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 //             crossAxisCount: 4),
// //                 //         itemCount: state.categories.length,
// //                 //         shrinkWrap: true,
// //                 //         itemBuilder: (BuildContext context, int index) {
// //                 //           return InkWell(
// //                 //             overlayColor: WidgetStatePropertyAll(MyTheme.transparent),
// //                 //             onTap: () {},
// //                 //             child: Column(
// //                 //               children: [
// //                 //                 Icon(Icons.category, size: 48), // استبدال الصورة الثابتة
// //                 //                 Text(
// //                 //                   state.categories[index].categoriesName?? 'Unknown'
// //                 //                   , style: textStyle(14, FontWeight.w600, MyTheme.blackColor),
// //                 //                 )
// //                 //               ],
// //                 //             ),
// //                 //           );
// //                 //         },
// //                 //       );
// //                 //     } else if (state is HomeErrorState) {
// //                 //       return Center(child: Text("Error: ${state.message}"));
// //                 //     }
// //                 //     return SizedBox.shrink();
// //                 //   },
// //                 // ),

// //                 horizontalListTitle("Discount guaranteed!"),

// //                 /// 🔹 BlocBuilder لعرض المنتجات المخفضة
// //                 BlocBuilder<HomeBloc, HomeState>(
// //   builder: (context, state) {
// //     if (state is FetchLoadingHomeDataState) {
// //       return const Center(child: CircularProgressIndicator());
// //     } else if (state is FetchSuccessHomeDataState) {
// //       return ListView.builder(
// //         shrinkWrap: true,
// //         // scrollDirection: Axis.horizontal,
// //         physics: const NeverScrollableScrollPhysics(),
// //         itemCount: state.items.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           return ListTile(
// //             leading: Image.network(
// //               state.items[index].itemImage ?? '',
// //               width: 50,
// //               height: 50,
// //               fit: BoxFit.cover,
// //               errorBuilder: (context, error, stackTrace) {
// //                 return const Icon(Icons.broken_image, size: 50);
// //               },
// //             ),
// //             title: Text(state.items[index].itemName ?? 'Unknown'),
// //             subtitle: Text("Discount: ${state.items[index].itemDiscount}%"),
// //           );
// //         },
// //       );
// //     } else if (state is HomeErrorState) {
// //       return Center(child: Text("Error: ${state.message}"));
// //     }
// //     return const SizedBox.shrink();
// //   },
// // ),
// // //                 BlocBuilder<HomeBloc, HomeState>(
// // //                   builder: (context, state) {
// // //                     if (state is FetchLoadingHomeDataState) {
// // //                       return Center(child: CircularProgressIndicator());
// // //                     } else if (state is FetchSuccessHomeDataState) {
// // //                       return ListView.builder(
// // //                         shrinkWrap: true,
// // //                         physics: NeverScrollableScrollPhysics(),
// // //                         itemCount: state.items.length,
// // //                         itemBuilder: (BuildContext context, int index) {
// // //                           return ListTile(
// // //                             title: Text(state.items[index].itemName ?? 'Unknown'
// // // ),
// // //                             subtitle: Text("Discount: ${state.items[index].itemDiscount}%"),
// // //                           );
// // //                         },
// // //                       );
// // //                     } else if (state is HomeErrorState) {
// // //                       return Center(child: Text("Error: ${state.message}"));
// // //                     }
// // //                     return SizedBox.shrink();
// // //                   },
// // //                 ),

// //                 horizontalListTitle("What's delicious around here?"),
// //                 horizontalList(Row2),
// //                 horizontalDishesList(dishes),
// //                 horizontalListTitle("Highlights of March"),
// //                 horizontalList(Row3),
// //                 horizontalListTitle("Nearby Restaurants"),
// //                 horizontalRestaurantList(restaurants),
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 20),
// //                   child: Text(
// //                     "Recommended For You ",
// //                     style: textStyle(20, FontWeight.w700, MyTheme.blackColor),
// //                   ),
// //                 ),
// //                 recommendedListView(recommendedList)
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// // ListView.builder(
// //   scrollDirection: Axis.horizontal,
// //   itemCount: state.items.length,
// //   itemBuilder: (BuildContext context, int index) {
// //     return Container(
// //       width: 160,
// //       margin: const EdgeInsets.symmetric(horizontal: 8),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(12),
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.2),
// //             blurRadius: 5,
// //             spreadRadius: 2,
// //           )
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Stack(
// //             children: [
// //               ClipRRect(
// //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// //                 child: Image.network(
// //                   state.items[index].itemImage ?? '',
// //                   height: 100,
// //                   width: double.infinity,
// //                   fit: BoxFit.cover,
// //                   errorBuilder: (context, error, stackTrace) {
// //                     return Container(
// //                       height: 100,
// //                       color: Colors.grey,
// //                       child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
// //                     );
// //                   },
// //                 ),
// //               ),
// //               Positioned(
// //                 top: 8,
// //                 left: 8,
// //                 child: Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.6),
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                   child: Text(
// //                     "${state.items[index].itemDiscount}% off",
// //                     style: const TextStyle(color: Colors.white, fontSize: 12),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Text(
// //               state.items[index].itemName ?? 'Unknown',
// //               style: textStyle(14, FontWeight.w600, MyTheme.blackColor),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   },
// // ),  // ListView.builder(
// //   scrollDirection: Axis.horizontal,
// //   itemCount: state.items.length,
// //   itemBuilder: (BuildContext context, int index) {
// //     return Container(
// //       width: 160,
// //       margin: const EdgeInsets.symmetric(horizontal: 8),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(12),
// //         color: Colors.white,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.2),
// //             blurRadius: 5,
// //             spreadRadius: 2,
// //           )
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Stack(
// //             children: [
// //               ClipRRect(
// //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// //                 child: Image.network(
// //                   state.items[index].itemImage ?? '',
// //                   height: 100,
// //                   width: double.infinity,
// //                   fit: BoxFit.cover,
// //                   errorBuilder: (context, error, stackTrace) {
// //                     return Container(
// //                       height: 100,
// //                       color: Colors.grey,
// //                       child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
// //                     );
// //                   },
// //                 ),
// //               ),
// //               Positioned(
// //                 top: 8,
// //                 left: 8,
// //                 child: Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.6),
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                   child: Text(
// //                     "${state.items[index].itemDiscount}% off",
// //                     style: const TextStyle(color: Colors.white, fontSize: 12),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Text(
// //               state.items[index].itemName ?? 'Unknown',
// //               style: textStyle(14, FontWeight.w600, MyTheme.blackColor),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   },
// // ),
// مهم ////////////////////////////////////////
import 'dart:async';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
// import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';
// import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
// import 'package:graduation_project/theme/theme.dart';
// import 'package:graduation_project/home_screen/ui/home_page/homewidgets.dart';
// // import 'package:graduation_project/home_screen/ui/home_page/homevariables.dart';
// import 'package:graduation_project/home_screen/ui/category_page/Services_Screen.dart';
// import 'package:graduation_project/home_screen/data/model/home_model_response/home_model_response.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class HomeScreen extends StatefulWidget {
//   static const String routName = 'HomeScreen';
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late Timer _timer;
//   int currentIndex = 0;

//   @override
//   void initState() {
//   super.initState();
//   _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
//     setState(() {});
//   });
//   // استدعاء الـ Events اللي محتاجاها
//   final homeBloc = BlocProvider.of<HomeBloc>(context);
//   homeBloc.add(FetchHomeDataEvent(HomeModelResponse())); // لجلب Categories و Discounted Items
//   homeBloc.add(FetchOffersEvent()); // لجلب الـ Offers
//   }

//   @override
//   void dispose() {
//     _timer.cancel(); // إيقاف الـ Timer لما الشاشة تتدمر
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     return BlocProvider(
//       create: (context) =>
//           HomeBloc()..add(FetchHomeDataEvent(HomeModelResponse())),

//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 homeTopBar(context),
//                 searchField(w),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Text(
//                     "Special Offer",
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Stack(
//                     alignment: Alignment.topCenter,
//                     children: [
//                       BlocBuilder<HomeBloc, HomeState>(
//   builder: (context, state) {
//     if (state is FetchOffersLoadingState) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (state is FetchOffersSuccessState) {
//       return CarouselSlider.builder(
//         itemCount: state.offers.length,
//         itemBuilder: (BuildContext context, int index, int realIndex) {
//           final offer = state.offers[index];
//           return Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   offer.itemsImage ?? '', // نفس الحقل موجود في Offersdatum
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Container(
//                       color: Colors.grey[300],
//                       child: const Center(child: CircularProgressIndicator()),
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       color: Colors.grey,
//                       child: const Icon(Icons.broken_image,
//                           size: 50, color: Colors.white),
//                     );
//                   },
//                 ),
//               ),
//               if (offer.itemsDiscount != null &&
//                   offer.itemsDiscount != "0") // التأكد إن الخصم مش 0 أو null
//                 Positioned(
//                   bottom: 8,
//                   right: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.red.withOpacity(0.8),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       "${offer.itemsDiscount}% OFF", // نفس الحقل موجود في Offersdatum
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//         options: CarouselOptions(
//           initialPage: 0,
//           viewportFraction: 1,
//           autoPlay: true,
//           autoPlayInterval: const Duration(seconds: 5),
//           autoPlayAnimationDuration: const Duration(milliseconds: 1000),
//           scrollDirection: Axis.horizontal,
//           onPageChanged: (index, reason) {
//             setState(() {
//               currentIndex = index;
//             });
//           },
//         ),
//       );
//     } else {
//       return const Center(child: Text("Error loading offers"));
//     }
//   },
// ),
//                       BlocBuilder<HomeBloc, HomeState>(
//                         builder: (context, state) {
//                           if (state is FetchSuccessHomeDataState) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 15),
//                               child: AnimatedSmoothIndicator(
//                                 activeIndex: currentIndex,
//                                 count: 4,
//                                 effect: SlideEffect(
//                                   activeDotColor: MyTheme.whiteColor,
//                                   dotColor: MyTheme.grayColor,
//                                   dotWidth: 85,
//                                   dotHeight: 4,
//                                 ),
//                               ),
//                             );
//                           }
//                           return const SizedBox
//                               .shrink(); // في حالة لم تكن البيانات محملة بعد
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 BlocBuilder<HomeBloc, HomeState>(
//                   builder: (context, state) {
//                     if (state is FetchLoadingHomeDataState) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is FetchSuccessHomeDataState) {
//                       return GridView.builder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 4,
//                           mainAxisSpacing: 16,
//                           crossAxisSpacing: 16,
//                           childAspectRatio: 0.9,
//                         ),
//                         itemCount: state.categories.length,
//                         shrinkWrap: true,
//                         itemBuilder: (BuildContext context, int index) {
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ServicesScreen(
//                                     categoryId: state
//                                         .categories[index].categoriesId
//                                         .toString(),
//                                     categoryName: state
//                                             .categories[index].categoriesName ??
//                                         'Unknown',
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: 70,
//                                   height: 70,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     gradient: const LinearGradient(
//                                       colors: [Colors.white, Colors.white],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.15),
//                                         blurRadius: 10,
//                                         spreadRadius: 2,
//                                         offset: const Offset(2, 4),
//                                       ),
//                                     ],
//                                   ),
//                                   child: ClipOval(
//                                     child: Image.network(
//                                       state.categories[index].categoriesImage ??
//                                           '',
//                                       fit: BoxFit.cover,
//                                       errorBuilder:
//                                           (context, error, stackTrace) {
//                                         return Container(
//                                           color: Colors.grey[300],
//                                           child: const Icon(Icons.broken_image,
//                                               size: 35, color: Colors.white),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Text(
//                                   state.categories[index].categoriesName ??
//                                       'Unknown',
//                                   textAlign: TextAlign.center,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium
//                                       ?.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14,
//                                         color: Colors.black87,
//                                       ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     } else if (state is HomeErrorState) {
//                       return Center(child: Text("Error: ${state.message}"));
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Text(
//                     "Discount guaranteed!",
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 BlocBuilder<HomeBloc, HomeState>(
//                   builder: (context, state) {
//                     if (state is FetchLoadingHomeDataState) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is FetchSuccessHomeDataState) {
//                       return SizedBox(
//                         height: 200,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: state.items.length,
//                           itemBuilder: (context, index) {
//                             final item = state.items[index];
//                             return Container(
//                               width: 180,
//                               margin: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.2),
//                                     blurRadius: 5,
//                                     spreadRadius: 2,
//                                   )
//                                 ],
//                               ),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Stack(
//                                       children: [
//                                         ClipRRect(
//                                           borderRadius:
//                                               const BorderRadius.vertical(
//                                                   top: Radius.circular(12)),
//                                           child: Image.network(
//                                             item.itemsImage ?? '',
//                                             height: 120,
//                                             width: double.infinity,
//                                             fit: BoxFit.cover,
//                                             errorBuilder:
//                                                 (context, error, stackTrace) {
//                                               return Container(
//                                                 height: 120,
//                                                 color: Colors.grey[300],
//                                                 child: const Center(
//                                                   child: Icon(
//                                                       Icons.broken_image,
//                                                       size: 50,
//                                                       color: Colors.white),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                         if (item.itemsDiscount != null &&
//                                             item.itemsDiscount != 0)
//                                           Positioned(
//                                             top: 8,
//                                             left: 0,
//                                             child: ClipPath(
//                                               clipper: RibbonClipper(),
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 4,
//                                                         horizontal: 12),
//                                                 color: Colors.redAccent
//                                                     .withOpacity(0.9),
//                                                 child: Text(
//                                                   "${item.itemsDiscount}% OFF",
//                                                   style: const TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             item.itemsName ?? 'Unknown',
//                                             style: const TextStyle(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Colors.black87),
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           const SizedBox(height: 4),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Price: ${item.itemsPrice ?? 'N/A'} EGP",
//                                                 style: const TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.green,
//                                                     fontWeight:
//                                                         FontWeight.w600),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   const Icon(Icons.star,
//                                                       size: 14,
//                                                       color:
//                                                           Colors.orangeAccent),
//                                                   Text(
//                                                     item.serviceRating
//                                                             ?.toString() ??
//                                                         'N/A',
//                                                     style: const TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.black54),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RibbonClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(size.width - 10, 0);
//     path.lineTo(size.width, size.height / 2);
//     path.lineTo(size.width - 10, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
