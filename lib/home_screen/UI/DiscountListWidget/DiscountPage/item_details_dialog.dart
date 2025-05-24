import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteBloc.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteEvent.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteState.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_event.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_state.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

void showItemDetailsDialog(BuildContext context, dynamic item) {
  double originalPrice =
      double.tryParse(item.itemsPrice?.toString() ?? '0.0') ?? 0.0;
  double discount =
      double.tryParse(item.itemsDiscount?.toString() ?? '0') ?? 0.0;
  double discountedPrice = originalPrice * (1 - (discount / 100));
  String restaurantName = item.serviceName ?? 'Unknown Restaurant';
  double rating =
      double.tryParse(item.serviceRating?.toString() ?? '0.0') ?? 0.0;
  String phoneNumber = item.servicePhone ?? 'Not Available';
  int quantity = 1;

  // تحويل itemsId لـ int بأمان
  final itemId = int.tryParse(item.itemsId?.toString() ?? '0') ?? 0;
  final userId = AppLocalStorage.getData('user_id');

  // تحقق من حالة العنصر في المفضلة عند فتح الـ Dialog
  if (userId != null && itemId != 0) {
    context.read<FavoriteBloc>().add(CheckFavoriteStatusEvent(
          userId: userId,
          itemId: itemId,
        ));
  }

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: StatefulBuilder(
          builder: (dialogContext, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: MediaQuery.of(dialogContext).size.width * 0.9,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[100]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12.r,
                    spreadRadius: 3.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.r)),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 160.h,
                            width: double.infinity,
                            child: item.itemsImage != null &&
                                    item.itemsImage!.isNotEmpty
                                ? Image.network(
                                    item.itemsImage!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 50.w,
                                          color: Colors.grey[500],
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    color: Colors.grey[300],
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 50.w,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                          ),
                          Container(
                            height: 160.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          if (discount != 0)
                            Positioned(
                              top: 8.h,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.redAccent,
                                      Colors.red[700]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.redAccent.withOpacity(0.3),
                                      blurRadius: 4.r,
                                      offset: Offset(0, 2.h),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '-${discount.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.itemsName ?? 'No Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Colors.black87,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            item.itemsDes ?? 'No Description',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey[700],
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Original',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    '${originalPrice.toStringAsFixed(2)} EGP',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey[600],
                                      decoration: discount > 0
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Discounted',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                  Text(
                                    '${discountedPrice.toStringAsFixed(2)} EGP',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.green[800],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 4.r,
                                  spreadRadius: 1.r,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.restaurant,
                                      size: 16.w,
                                      color: MyTheme.orangeColor,
                                    ),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        restaurantName,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16.w,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      '$rating / 5',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 16.w,
                                      color: Colors.green[700],
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      phoneNumber,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BlocListener<FavoriteBloc, FavoriteState>(
                                listener: (context, state) {
                                  if (state is AddToFavoriteSuccessState) {
                                    ScaffoldMessenger.of(dialogContext)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Added to Favorites!',
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (state
                                      is DeleteFavoriteItemSuccessState) {
                                    ScaffoldMessenger.of(dialogContext)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Removed from Favorites!',
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (state is AddToFavoriteErrorState) {
                                    ScaffoldMessenger.of(dialogContext)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to add to favorites: ${state.message}',
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
                                  } else if (state
                                      is DeleteFavoriteItemErrorState) {
                                    ScaffoldMessenger.of(dialogContext)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to remove from favorites: ${state.message}',
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
                                  }
                                },
                                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                                  builder: (context, state) {
                                    bool isFavorite = false;
                                    if (state
                                            is CheckFavoriteStatusSuccessState &&
                                        state.itemId == itemId) {
                                      isFavorite = state.isFavorite;
                                    }

                                    return _buildActionButton(
                                      icon: isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.redAccent,
                                      onTap: () {
                                        if (userId == null) {
                                          ScaffoldMessenger.of(dialogContext)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Please log in to add to favorites',
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                              backgroundColor: Colors.redAccent,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                          return;
                                        }
                                        if (isFavorite) {
                                          context.read<FavoriteBloc>().add(
                                                DeleteFavoriteItemEvent(
                                                  userId: userId,
                                                  itemId: itemId,
                                                ),
                                              );
                                        } else {
                                          context.read<FavoriteBloc>().add(
                                                AddToFavoriteEvent(
                                                  userId: userId,
                                                  itemId: itemId,
                                                ),
                                              );
                                          // تحقق من حالة العنصر مباشرة بعد الإضافة
                                          context.read<FavoriteBloc>().add(
                                                CheckFavoriteStatusEvent(
                                                  userId: userId,
                                                  itemId: itemId,
                                                ),
                                              );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      size: 24.w,
                                      color: MyTheme.orangeColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) quantity--;
                                      });
                                    },
                                  ),
                                  Text(
                                    '$quantity',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: MyTheme.orangeColor,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      size: 24.w,
                                      color: MyTheme.orangeColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              BlocListener<CartBloc, CartState>(
                                listener: (context, state) {
                                  if (state is AddToCartSuccessState) {
                                    ScaffoldMessenger.of(dialogContext)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Added to Cart!',
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  } else if (state is AddToCartErrorState) {
                                    ScaffoldMessenger.of(dialogContext)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to add to cart: ${state.message}',
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
                                  }
                                },
                                child: _buildActionButton(
                                  icon: Icons.add_shopping_cart,
                                  color: MyTheme.orangeColor,
                                  onTap: () {
                                    if (userId != null) {
                                      if (itemId != 0) {
                                        context.read<CartBloc>().add(
                                              AddToCartEvent(
                                                userId: userId,
                                                itemId: itemId,
                                                quantity: quantity,
                                                type: 'item',
                                              ),
                                            );
                                      } else {
                                        ScaffoldMessenger.of(dialogContext)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Cannot add to cart: Missing item ID',
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                            backgroundColor: Colors.redAccent,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(dialogContext)
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
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!, width: 1),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print("Dialog closed");
                          }
                          Navigator.pop(dialogContext);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          elevation: 4,
                        ),
                        child: Text(
                          'Close',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
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
