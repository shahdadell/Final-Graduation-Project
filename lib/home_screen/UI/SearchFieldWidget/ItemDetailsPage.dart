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
import 'package:graduation_project/home_screen/data/model/search_model_response/SearchModelResponse.dart'
    as searchModel;
import 'package:graduation_project/local_data/shared_preference.dart';

class ItemDetailsPage extends StatefulWidget {
  static const String routeName = 'ItemDetailsPage';
  final searchModel.ItemData item;

  const ItemDetailsPage({super.key, required this.item});

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    final userId = AppLocalStorage.getData('user_id');
    final itemId = int.tryParse(widget.item.itemsId?.toString() ?? '0') ?? 0;
    if (userId != null && itemId != 0) {
      context.read<FavoriteBloc>().add(CheckFavoriteStatusEvent(
            userId: userId,
            itemId: itemId,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final userId = AppLocalStorage.getData('user_id');
    final itemId = int.tryParse(widget.item.itemsId?.toString() ?? '0') ?? 0;

    double price = double.tryParse(widget.item.itemsPrice ?? '0') ?? 0.0;
    double discount = double.tryParse(widget.item.itemsDiscount ?? '0') ?? 0.0;
    double discountedPrice = price * (1 - (discount / 100));

    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: MyTheme.whiteColor,
              size: 20.w,
            ),
          ),
        ),
        title: Text(
          widget.item.itemsName ?? 'Item Details',
          style: textTheme.displayLarge?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: MyTheme.whiteColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.orangeColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15.r),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 160.h, // تصغير حجم الصورة
                      child: widget.item.itemsImage != null &&
                              widget.item.itemsImage!.isNotEmpty
                          ? Image.network(
                              widget.item.itemsImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: MyTheme.grayColor.withOpacity(0.2),
                                child: Icon(Icons.broken_image,
                                    size: 30.sp, color: MyTheme.grayColor2),
                              ),
                            )
                          : Container(
                              color: MyTheme.grayColor.withOpacity(0.2),
                              child: Icon(Icons.broken_image,
                                  size: 30.sp, color: MyTheme.grayColor2),
                            ),
                    ),
                    if (discount > 0)
                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.redAccent, Colors.red[700]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
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
            ),
            SizedBox(height: 12.h),

            // التفاصيل
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MyTheme.whiteColor,
                      MyTheme.grayColor.withOpacity(0.05)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الاسم
                    Text(
                      widget.item.itemsName ?? 'Not Available',
                      style: textTheme.titleLarge?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 18.sp, // تصغير حجم النص
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),

                    // الوصف
                    Text(
                      'Description:',
                      style: textTheme.titleMedium?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.item.itemsDescription ?? 'No Description',
                      style: textTheme.bodyMedium?.copyWith(
                        color: MyTheme.grayColor2,
                        fontSize: 12.sp, // تصغير حجم النص
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // السعر والخصم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Original Price',
                              style: textTheme.bodySmall?.copyWith(
                                color: MyTheme.grayColor2,
                                fontSize: 11.sp,
                              ),
                            ),
                            Text(
                              '${price.toStringAsFixed(2)} EGP',
                              style: textTheme.bodyMedium?.copyWith(
                                color: MyTheme.grayColor2,
                                fontSize: 12.sp,
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
                              'Discounted Price',
                              style: textTheme.bodySmall?.copyWith(
                                color: MyTheme.greenColor,
                                fontSize: 11.sp,
                              ),
                            ),
                            Text(
                              '${discountedPrice.toStringAsFixed(2)} EGP',
                              style: textTheme.titleMedium?.copyWith(
                                color: MyTheme.greenColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // الكمية
                    Text(
                      'Available Quantity: ${widget.item.itemsCount ?? 'N/A'}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // التصنيف
                    Text(
                      'Category: ${widget.item.itemsCat ?? 'N/A'}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // تاريخ الإضافة
                    Text(
                      'Added On: ${widget.item.itemsDate ?? 'N/A'}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // الحالة
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: widget.item.itemsActive == "1"
                            ? MyTheme.greenColor.withOpacity(0.2)
                            : MyTheme.redColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        widget.item.itemsActive == "1"
                            ? 'Available'
                            : 'Not Available',
                        style: textTheme.bodyMedium?.copyWith(
                          color: widget.item.itemsActive == "1"
                              ? MyTheme.greenColor
                              : MyTheme.redColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // أزرار Add to Favorites و Add to Cart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocListener<FavoriteBloc, FavoriteState>(
                  listener: (context, state) {
                    if (state is AddToFavoriteSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Added to Favorites!',
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
                    } else if (state is DeleteFavoriteItemSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Removed from Favorites!',
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
                    } else if (state is AddToFavoriteErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Failed to add to favorites: ${state.message}',
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
                    } else if (state is DeleteFavoriteItemErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Failed to remove from favorites: ${state.message}',
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
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      bool isFavorite = false;
                      if (state is CheckFavoriteStatusSuccessState &&
                          state.itemId == itemId) {
                        isFavorite = state.isFavorite;
                      }

                      return _buildActionButton(
                        icon:
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.redAccent,
                        onTap: () {
                          if (userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please log in to add to favorites',
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Cannot add to cart: Missing item ID',
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
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please log in to add to cart',
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
                  ),
                ),
              ],
            ),
          ],
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
