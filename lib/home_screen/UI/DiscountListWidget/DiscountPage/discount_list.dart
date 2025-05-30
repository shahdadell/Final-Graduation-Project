import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'discount_card.dart';

class DiscountList extends StatelessWidget {
  const DiscountList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (kDebugMode) {
          print("Current State in DiscountList: $state");
        }
        if (state is FetchLoadingHomeDataState) {
          return Center(
            child: CircularProgressIndicator(
              color: MyTheme.orangeColor,
              strokeWidth: 4,
            ),
          );
        } else if (state is FetchSuccessHomeDataState) {
          if (kDebugMode) {
            print("Items in FetchSuccessHomeDataState: ${state.items.length}");
          }
          if (state.items.isEmpty) {
            return _buildEmptyState();
          }
          return _buildDiscountList(context, state.items);
        }
        return _buildErrorState();
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sentiment_dissatisfied,
              size: 70.w, color: Colors.grey[400]),
          SizedBox(height: 20.h),
          Text(
            'Oops! No Discounts Here',
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

  Widget _buildErrorState() {
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
        ],
      ),
    );
  }

  Widget _buildDiscountList(BuildContext context, List<dynamic> items) {
    return ListView.builder(
      padding: EdgeInsets.all(15.w),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: buildDiscountCard(context, item),
        );
      },
    );
  }
}
