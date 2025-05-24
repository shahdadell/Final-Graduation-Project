import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/UI/TopSellingListWidget/TopSellingPage/topselling_card.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'package:graduation_project/home_screen/data/model/topSelling_model_response/TopSellinModelResponse.dart';

class TopSellingList extends StatelessWidget {
  const TopSellingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        print("Current State in TopSellingList: $state");
        if (state is FetchTopSellingLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: MyTheme.orangeColor,
              strokeWidth: 4,
            ),
          );
        } else if (state is FetchTopSellingSuccessState) {
          if (kDebugMode) {
            print(
                "Items in FetchTopSellingSuccessState: ${state.topSelling.length}");
          }
          if (state.topSelling.isEmpty) {
            return _buildEmptyState();
          }
          return _buildTopSellingList(context, state.topSelling);
        } else if (state is FetchTopSellingErrorState) {
          return _buildErrorState(state.message);
        }
        return _buildErrorState("Waiting for data...");
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
            'Oops! No Top Selling Items Here',
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

  Widget _buildErrorState(String message) {
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
            message,
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSellingList(
      BuildContext context, List<TopSellingData> items) {
    return ListView.builder(
      padding: EdgeInsets.all(15.w),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        if (kDebugMode) {
          print("Building card for item: ${item.itemsName} at index: $index");
        }
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: buildTopCard(context, item),
        );
      },
    );
  }
}
