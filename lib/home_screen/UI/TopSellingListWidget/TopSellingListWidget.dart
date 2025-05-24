import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'TopSellingPage/AllTopSellingPage.dart';
import 'top_selling_card.dart';

class TopSellingListWidget extends StatelessWidget {
  const TopSellingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 10.h),
          child: Text(
            "Hot Picks 🔥",
            style: TextStyle(
              fontSize: 18.sp,
              color: MyTheme.blackColor,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  blurRadius: 3.r,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) {
            return current is FetchLoadingHomeDataState ||
                current is FetchSuccessHomeDataState ||
                current is HomeErrorState;
          },
          builder: (context, state) {
            if (kDebugMode) {
              print("TopSellingListWidget State: $state");
            }
            if (state is FetchLoadingHomeDataState) {
              return Container(
                height: 200.h,
                child: Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.orangeColor,
                    strokeWidth: 3.w,
                    backgroundColor: Colors.grey[200],
                  ),
                ),
              );
            } else if (state is FetchSuccessHomeDataState) {
              if (kDebugMode) {
                print("Top Selling Items Loaded: ${state.topSelling.length}");
              }
              final itemCount =
                  state.topSelling.length > 4 ? 5 : state.topSelling.length;
              return SizedBox(
                height: 200.h,
                child: state.topSelling.isEmpty
                    ? Center(
                        child: Text(
                          "No top selling items available",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          if (index == 4 && state.topSelling.length > 4) {
                            return _buildShowMoreCard(context);
                          }
                          final item = state.topSelling[index];
                          return buildTopSellingCard(context, item);
                        },
                      ),
              );
            } else if (state is HomeErrorState) {
              if (kDebugMode) {
                print("Top Selling Error: ${state.message}");
              }
              return Container(
                height: 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 50.w,
                        color: Colors.redAccent,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "Failed to Load Hot Picks",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Error: ${state.message}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<HomeBloc>()
                              .add(FetchHomeDataEvent(null));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                MyTheme.orangeColor,
                                Colors.orangeAccent,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30.r),
                            boxShadow: [
                              BoxShadow(
                                color: MyTheme.orangeColor.withOpacity(0.4),
                                blurRadius: 8.r,
                                spreadRadius: 2.r,
                              ),
                            ],
                          ),
                          child: Text(
                            "Try Again",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (kDebugMode) {
              print("Initial Fallback State: $state");
            }
            return Container(
              height: 200.h,
              child: Center(
                child: CircularProgressIndicator(
                  color: MyTheme.orangeColor,
                  strokeWidth: 3.w,
                  backgroundColor: Colors.grey[200],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildShowMoreCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AllTopSellingPage()),
        );
      },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Show More",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: MyTheme.orangeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6.w),
              Icon(
                Icons.arrow_forward_ios,
                size: 14.w,
                color: MyTheme.orangeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
