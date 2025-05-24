import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteBloc.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteEvent.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteState.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import '../DiscountListWidget/DiscountPage/item_details_dialog.dart';

class ItemsGrid extends StatelessWidget {
  const ItemsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final int? userId = AppLocalStorage.getData('user_id');
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, homeState) {
      if (homeState is FetchServiceItemsLoadingState) {
        return Center(
          child: CircularProgressIndicator(color: MyTheme.orangeColor),
        );
      } else if (homeState is FetchServiceItemsSuccessState) {
        if (homeState.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sentiment_dissatisfied,
                    size: 70.w, color: Colors.grey[400]),
                SizedBox(height: 20.h),
                Text(
                  'Oops! No Items Here',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Check back later!',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.h,
              childAspectRatio: 0.75,
            ),
            itemCount: homeState.items.length,
            itemBuilder: (context, index) {
              final item = homeState.items[index];
              final itemId = int.tryParse(item.itemsId ?? '0') ?? 0;

              context.read<FavoriteBloc>().add(CheckFavoriteStatusEvent(
                    userId: userId ?? 0,
                    itemId: itemId,
                  ));

              return BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, favoriteState) {
                  bool isFavorite = item.favorite == '1' || item.favorite == 1;
                  if (favoriteState is CheckFavoriteStatusSuccessState &&
                      favoriteState.itemId == itemId) {
                    isFavorite = favoriteState.isFavorite;
                  }

                  return GestureDetector(
                    onTap: () {
                      showItemDetailsDialog(context, item);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey[50]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8.r,
                            spreadRadius: 2.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.r)),
                                  child: SizedBox(
                                    height: 150.h,
                                    width: double.infinity,
                                    child: item.itemsImage != null &&
                                            item.itemsImage!.isNotEmpty
                                        ? Image.network(
                                            item.itemsImage!,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Container(
                                                color: Colors.grey[200],
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: MyTheme.orangeColor,
                                                    strokeWidth: 2.w,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.grey[200],
                                                child: Icon(Icons.broken_image,
                                                    size: 50.w,
                                                    color: Colors.grey[400]),
                                              );
                                            },
                                          )
                                        : Container(
                                            color: Colors.grey[200],
                                            child: Icon(Icons.broken_image,
                                                size: 50.w,
                                                color: Colors.grey[400]),
                                          ),
                                  ),
                                ),
                                if (item.itemsDiscount != null &&
                                    double.tryParse(item.itemsDiscount ?? '0')! >
                                        0)
                                  Positioned(
                                    top: 10.h,
                                    left: 10.w,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.redAccent,
                                            Colors.red[700]!
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Text(
                                        '-${(double.tryParse(item.itemsDiscount ?? '0') ?? 0).toStringAsFixed(0)}%',
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
                            padding: EdgeInsets.all(10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.itemsName ?? 'No Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  item.itemsDes ?? 'No Description',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: MyTheme.grayColor2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Text(
                                          '${double.tryParse(item.itemsPrice ?? '0')?.toStringAsFixed(2) ?? 'N/A'} EGP',
                                          style: TextStyle(
                                            color: Colors.green[800],
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (userId == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Please log in to add to favorites',
                                                    style: TextStyle(
                                                        fontSize: 13.sp),
                                                  ),
                                                  backgroundColor:
                                                      Colors.black87,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r)),
                                                  duration:
                                                      Duration(seconds: 2),
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
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Removed from Favorites!',
                                                    style: TextStyle(
                                                        fontSize: 13.sp),
                                                  ),
                                                  backgroundColor:
                                                      Colors.black87,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r)),
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                            } else {
                                              context.read<FavoriteBloc>().add(
                                                    AddToFavoriteEvent(
                                                      userId: userId,
                                                      itemId: itemId,
                                                    ),
                                                  );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Added to Favorites!',
                                                    style: TextStyle(
                                                        fontSize: 13.sp),
                                                  ),
                                                  backgroundColor:
                                                      Colors.black87,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r)),
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  blurRadius: 4.r,
                                                  spreadRadius: 1.r,
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isFavorite
                                                  ? Colors.redAccent
                                                  : Colors.grey[600],
                                              size: 15.w,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 6.w),
                                        GestureDetector(
                                          onTap: () {
                                            showItemDetailsDialog(
                                                context, item);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  blurRadius: 4.r,
                                                  spreadRadius: 1.r,
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.add_shopping_cart,
                                              color: MyTheme.orangeColor,
                                              size: 15.w,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
            },
          ),
        );
      } else if (homeState is FetchServiceItemsErrorState) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 60.w, color: Colors.redAccent),
              SizedBox(height: 20.h),
              Text(
                "Oops! Something Went Wrong",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Error: ${homeState.message}",
                style: TextStyle(fontSize: 16.sp, color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
      return SizedBox.shrink();
    });
  }
}