import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteBloc.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteEvent.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteState.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WishlistScreen extends StatefulWidget {
  static const String routeName = '/wishlist';
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<dynamic> _favorites = []; // لتخزين قايمة الفيفورت الحالية

  @override
  void initState() {
    super.initState();
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId != null) {
      context.read<FavoriteBloc>().add(FetchFavoriteEvent(userId: userId));
    }
  }

  @override
  void didUpdateWidget(WishlistScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId != null) {
      context.read<FavoriteBloc>().add(FetchFavoriteEvent(userId: userId));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshFavorites(BuildContext context) async {
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId != null) {
      context.read<FavoriteBloc>().add(FetchFavoriteEvent(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId == null) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          color: MyTheme.whiteColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/images/favouriteEmpty.json',
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Please log in to view your favorites',
                  style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: MyTheme.mauveColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.orangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
                    elevation: 5,
                    shadowColor: MyTheme.orangeColor.withOpacity(0.4),
                  ),
                  child: Text(
                    'Go to Login',
                    style: MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms).slideY(
              begin: 0.2,
              end: 0.0,
              duration: 600.ms,
              curve: Curves.easeOut,
            ),
          ),
        ),
      );
    }

    return BlocListener<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is AddToFavoriteSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle_rounded,
                      color: MyTheme.whiteColor, size: 16.w),
                  SizedBox(width: 8.w),
                  Text('Item added to favorites'),
                ],
              ),
              backgroundColor: MyTheme.greenColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 6,
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is AddToFavoriteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_rounded,
                      color: MyTheme.whiteColor, size: 16.w),
                  SizedBox(width: 8.w),
                  Text('Failed to add item: ${state.message}'),
                ],
              ),
              backgroundColor: MyTheme.redColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 6,
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is DeleteFavoriteItemSuccessState) {
          // تحديث القايمة بعد الحذف
          final int? userId = AppLocalStorage.getData('user_id');
          if (userId != null) {
            context
                .read<FavoriteBloc>()
                .add(FetchFavoriteEvent(userId: userId));
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle_rounded,
                      color: MyTheme.whiteColor, size: 16.w),
                  SizedBox(width: 8.w),
                  Text('Item removed from favorites'),
                ],
              ),
              backgroundColor: MyTheme.greenColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 6,
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is DeleteFavoriteItemErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_rounded,
                      color: MyTheme.whiteColor, size: 16.w),
                  SizedBox(width: 8.w),
                  Text('Failed to remove item: ${state.message}'),
                ],
              ),
              backgroundColor: MyTheme.redColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 6,
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is FetchFavoriteSuccessState) {
          setState(() {
            _favorites = state.favoriteViewResponse.data ?? [];
          });
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          color: MyTheme.whiteColor,
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FetchFavoriteErrorState) {
                return RefreshIndicator(
                  onRefresh: () => _refreshFavorites(context),
                  color: MyTheme.orangeColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 200.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_rounded,
                              size: 80.w,
                              color: MyTheme.redColor.withOpacity(0.7),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Error: ${state.message}',
                              style: MyTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontSize: 18.sp,
                                color: MyTheme.redColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.h),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<FavoriteBloc>()
                                    .add(FetchFavoriteEvent(userId: userId));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyTheme.orangeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.w, vertical: 12.h),
                                elevation: 5,
                                shadowColor:
                                MyTheme.orangeColor.withOpacity(0.4),
                              ),
                              child: Text(
                                'Retry',
                                style: MyTheme
                                    .lightTheme.textTheme.displayMedium
                                    ?.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (_favorites.isEmpty) {
                return RefreshIndicator(
                  onRefresh: () => _refreshFavorites(context),
                  color: MyTheme.orangeColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: _buildEmptyFavorites(context),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => _refreshFavorites(context),
                color: MyTheme.orangeColor,
                child: ListView.builder(
                  padding:
                  EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  itemCount: _favorites.length,
                  itemBuilder: (context, index) {
                    final item = _favorites[index];
                    return BlocConsumer<FavoriteBloc, FavoriteState>(
                      listener: (context, state) {
                        // تم التعامل مع الحالات في BlocListener الرئيسي
                      },
                      builder: (context, state) {
                        bool isLoading = state is DeleteFavoriteItemLoadingState &&
                            state.itemId == int.parse(item.itemsId ?? '0');

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 6.h),
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: MyTheme.whiteColor,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: MyTheme.grayColor.withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                  blurRadius: 8.r,
                                  spreadRadius: 1.r,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: item.itemsImage != null
                                      ? CachedNetworkImage(
                                    imageUrl: item.itemsImage!,
                                    width: 70.w,
                                    height: 60.h,
                                    fit: BoxFit.cover,
                                    memCacheHeight: (60.h).toInt(),
                                    memCacheWidth: (60.w).toInt(),
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: MyTheme.orangeColor,
                                        strokeWidth: 2.w,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(
                                          Icons.favorite_rounded,
                                          size: 24.w,
                                          color: MyTheme.orangeColor,
                                        ),
                                  )
                                      : Icon(
                                    Icons.favorite_rounded,
                                    size: 24.w,
                                    color: MyTheme.orangeColor,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.itemsName ?? 'No Name',
                                        style: MyTheme
                                            .lightTheme.textTheme.titleSmall
                                            ?.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: MyTheme.mauveColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        '${double.tryParse(item.itemsPrice ?? '0.0')?.toStringAsFixed(2) ?? '0.00'} EGP',
                                        style: MyTheme
                                            .lightTheme.textTheme.titleSmall
                                            ?.copyWith(
                                          fontSize: 12.sp,
                                          color: MyTheme.greenColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: isLoading
                                      ? null
                                      : () {
                                    context.read<FavoriteBloc>().add(
                                      DeleteFavoriteItemEvent(
                                        userId: userId,
                                        itemId: int.parse(
                                            item.itemsId ?? '0'),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.w),
                                    decoration: BoxDecoration(
                                      color: MyTheme.redColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: isLoading
                                        ? SizedBox(
                                      width: 18.w,
                                      height: 18.h,
                                      child: CircularProgressIndicator(
                                        color: MyTheme.orangeColor,
                                        strokeWidth: 2.w,
                                      ),
                                    )
                                        : Icon(
                                      Icons.delete_rounded,
                                      size: 18.w,
                                      color: MyTheme.orangeColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 500.ms, delay: (100 * index).ms)
                            .slideX(
                          begin: 0.2,
                          end: 0.0,
                          duration: 500.ms,
                          curve: Curves.easeOut,
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Favorites",
        style: MyTheme.lightTheme.textTheme.displayLarge?.copyWith(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: MyTheme.whiteColor,
          shadows: [
            Shadow(
              color: MyTheme.grayColor3,
              blurRadius: 3.r,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(
        begin: 0.1,
        end: 0.0,
        duration: 400.ms,
        curve: Curves.easeOut,
      ),
      centerTitle: true,
      backgroundColor: MyTheme.orangeColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.r),
        ),
      ),
    );
  }

  Widget _buildEmptyFavorites(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/favouriteEmpty.json',
              width: 200.w,
              height: 200.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20.h),
            Text(
              'Your favorites list is empty',
              style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: MyTheme.mauveColor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Start adding items now!',
              style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontSize: 16.sp,
                color: MyTheme.grayColor2,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(
      begin: 0.2,
      end: 0.0,
      duration: 600.ms,
      curve: Curves.easeOut,
    );
  }
}