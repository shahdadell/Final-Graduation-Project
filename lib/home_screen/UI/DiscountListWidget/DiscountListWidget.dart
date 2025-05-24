import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Home_Screen/UI/DiscountListWidget/DiscountCard.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'DiscountPage/AllDiscountsPage.dart';

class DiscountListWidget extends StatelessWidget {
  const DiscountListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        SizedBox(height: 4.h),
        _buildContent(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 4.h),
      child: Text(
        "Discount Guaranteed 🤑",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          shadows: [
            Shadow(
              color: Colors.black26,
              offset: const Offset(1, 1),
              blurRadius: 3.r,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is FetchLoadingHomeDataState) {
          return SizedBox(
            height: 130.h,
            child: Center(
              child: CircularProgressIndicator(
                color: MyTheme.orangeColor,
                strokeWidth: 6.w,
                backgroundColor: Colors.grey[200],
              ),
            ),
          );
        } else if (state is FetchSuccessHomeDataState) {
          final itemCount = state.items.length > 4 ? 5 : state.items.length;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SizedBox(
              height: 130.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (index == 4 && state.items.length > 3) {
                    return _buildShowMoreCard(context);
                  }
                  final item = state.items[index];
                  return DiscountCard(item: item);
                },
              ),
            ),
          );
        } else if (state is HomeErrorState) {
          return Container(
            height: 130.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 50.w,
                    color: Colors.redAccent,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Failed to load discounts",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox(
          height: 130.h,
          child: Center(
            child: CircularProgressIndicator(
              color: MyTheme.orangeColor,
              strokeWidth: 3.w,
              backgroundColor: Colors.grey[200],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShowMoreCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllDiscountsPage()),
        );
      },
      child: Container(
        width: 120.w,
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
