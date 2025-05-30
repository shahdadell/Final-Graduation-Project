import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/data/model/orders_model_response/details_response/datumOrderDetails.dart';
import '../../bloc/Cart/orders_bloc.dart';
import '../../bloc/Cart/orders_event.dart';
import '../../bloc/Cart/orders_state.dart';
import '../../data/repo/orders_repo.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String ordersId;

  const OrderDetailsScreen({super.key, required this.ordersId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(orderRepo: OrderRepo())
        ..add(FetchOrderDetailsEvent(ordersId: ordersId)),
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: MyTheme.whiteColor,
                size: 24.w,
              ),
            ),
          ),
          title: Text(
            "Order #$ordersId Details",
            style: MyTheme.lightTheme.textTheme.displayLarge?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: MyTheme.whiteColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: MyTheme.orangeColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is FetchOrderDetailsLoadingState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: MyTheme.orangeColor,
                      strokeWidth: 3.w,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Loading order details...',
                      style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontSize: 18.sp,
                        color: MyTheme.mauveColor,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is FetchOrderDetailsSuccessState) {
              final items = state.detailsResponse.data ?? [];
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 80.w,
                        color: MyTheme.mauveColor.withOpacity(0.7),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'No items found for this order',
                        style:
                            MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontSize: 18.sp,
                          color: MyTheme.mauveColor,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _buildOrderItemCard(item);
                },
              );
            } else if (state is FetchOrderDetailsErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 80.w,
                      color: MyTheme.redColor.withOpacity(0.7),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Failed to load order details',
                      style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontSize: 18.sp,
                        color: MyTheme.redColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      state.message,
                      style: MyTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp,
                        color: MyTheme.grayColor2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<OrderBloc>()
                            .add(FetchOrderDetailsEvent(ordersId: ordersId));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.orangeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 12.h),
                      ),
                      child: Text(
                        'Retry',
                        style: MyTheme.lightTheme.textTheme.displayMedium
                            ?.copyWith(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildOrderItemCard(Datumorderdetails item) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: MyTheme.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: MyTheme.orangeColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: MyTheme.grayColor3.withOpacity(0.3),
            blurRadius: 6.r,
            spreadRadius: 1.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              item.image ?? '',
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80.w,
                height: 80.h,
                color: MyTheme.grayColor2,
                child: const Icon(Icons.error, color: MyTheme.redColor),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // تفاصيل المنتج
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'N/A',
                  style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.mauveColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Qty: ${item.cartQuantity ?? '0'}',
                      style: MyTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: MyTheme.grayColor2,
                      ),
                    ),
                    Text(
                      'Price: ${item.itemsPrice ?? '0.0'} EGP',
                      style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontSize: 12.sp,
                        color: MyTheme.greenColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
