import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_event.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_state.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'package:graduation_project/home_screen/data/model/offers_model_response/offers_model_response/offers_model_response.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

class OffersScreen extends StatelessWidget {
  static const routeName = '/offers';

  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchOffersEvent());
    final userId = AppLocalStorage.getData('user_id');

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: MyTheme.whiteColor,
              size: 24.w,
            ),
          ),
        ),
        title: Text(
          "Special Offers",
          style: MyTheme.lightTheme.textTheme.displayLarge?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: MyTheme.grayColor3,
                blurRadius: 3.r,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.orangeColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.r),
          ),
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is AddToCartSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Added to Cart!',
                  style: TextStyle(fontSize: 14.sp),
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          } else if (state is AddToCartErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to add to cart: ${state.message}',
                  style: TextStyle(fontSize: 14.sp),
                ),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is FetchOffersLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyTheme.orangeColor,
                  strokeWidth: 3.w,
                ),
              );
            } else if (state is FetchOffersErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 60.w,
                      color: MyTheme.orangeColor.withOpacity(0.7),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Error loading offers: ${state.message}",
                      style: textTheme.bodyMedium?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(FetchOffersEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.orangeColor,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        "Try Again",
                        style: textTheme.bodyMedium?.copyWith(
                          color: MyTheme.whiteColor,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is FetchOffersSuccessState) {
              final offers = state.offers;
              if (offers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_offer_outlined,
                        size: 80.w,
                        color: MyTheme.orangeColor.withOpacity(0.7),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No Offers Available Right Now',
                        style: textTheme.titleLarge?.copyWith(
                          color: MyTheme.blackColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Check back soon for exciting deals! 🎉',
                        style: textTheme.bodyMedium?.copyWith(
                          color: MyTheme.grayColor2,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  final displayTitle =
                      offer.title == null || offer.title!.isEmpty
                          ? 'No Title'
                          : offer.title!.length > 25
                              ? '${offer.title!.substring(0, 25)}...'
                              : offer.title!;
                  return AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                        color: MyTheme.whiteColor,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: MyTheme.orangeColor.withOpacity(0.3),
                            blurRadius: 10.r,
                            spreadRadius: 2.r,
                            offset: Offset(0, 3.h),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.r)),
                                child: Image.network(
                                  offer.image ?? '',
                                  width: double.infinity,
                                  height: 180.h,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      width: double.infinity,
                                      height: 180.h,
                                      color:
                                          MyTheme.grayColor2.withOpacity(0.1),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: MyTheme.orangeColor,
                                          strokeWidth: 2.w,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: double.infinity,
                                      height: 180.h,
                                      color:
                                          MyTheme.grayColor2.withOpacity(0.1),
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 40.w,
                                        color: MyTheme.grayColor2,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 12.h,
                                left: 12.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: MyTheme.orangeColor,
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: MyTheme.grayColor3,
                                        blurRadius: 3.r,
                                        offset: Offset(0, 1.h),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'Save ${index * 10 + 20}%!',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: MyTheme.whiteColor,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 12.h,
                                right: 12.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: MyTheme.yellowColor,
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: MyTheme.grayColor3,
                                        blurRadius: 3.r,
                                        offset: Offset(0, 1.h),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: MyTheme.blackColor,
                                        size: 14.w,
                                      ),
                                      SizedBox(width: 3.w),
                                      Text(
                                        'Ends in 2h 15m',
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: MyTheme.blackColor,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayTitle,
                                        style: textTheme.titleLarge?.copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: MyTheme.blackColor,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      if (offer.price != null)
                                        Row(
                                          children: [
                                            Text(
                                              "${offer.price} EGP",
                                              style:
                                                  textTheme.bodyLarge?.copyWith(
                                                color: MyTheme.orangeColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              "${(double.tryParse(offer.price.toString()) ?? 0.0) * 1.3}",
                                              style: textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: MyTheme.grayColor2,
                                                fontSize: 13.sp,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                _buildActionButton(
                                  icon: Icons.add_shopping_cart,
                                  color: MyTheme.orangeColor,
                                  onTap: () {
                                    if (userId == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please log in to add to cart',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                          backgroundColor: Colors.redAccent,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      return;
                                    }
                                    final itemId = int.tryParse(
                                            offer.id?.toString() ?? '0') ??
                                        0;
                                    if (itemId == 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Cannot add to cart: Invalid item ID',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                          backgroundColor: Colors.redAccent,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      return;
                                    }
                                    context.read<CartBloc>().add(
                                          AddToCartEvent(
                                            userId: userId,
                                            itemId: itemId,
                                            quantity: 1,
                                            type: 'offer',
                                          ),
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 4.r,
              spreadRadius: 1.r,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: 18.w,
        ),
      ),
    );
  }
}
