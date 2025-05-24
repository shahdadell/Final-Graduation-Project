import 'dart:async'; // أضيفي المكتبة دي عشان Polling
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../Theme/theme.dart';
import '../../bloc/Cart/orders_bloc.dart';
import '../../bloc/Cart/orders_event.dart';
import '../../bloc/Cart/orders_state.dart';
import '../../data/model/orders_model_response/ArchiveResponse.dart';
import 'OrderDetailsScreen.dart';

class ArchivedOrdersScreen extends StatefulWidget {
  final int userId;

  const ArchivedOrdersScreen({super.key, required this.userId});

  @override
  _ArchivedOrdersScreenState createState() => _ArchivedOrdersScreenState();
}

class _ArchivedOrdersScreenState extends State<ArchivedOrdersScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // نبدأ Polling كل 30 ثانية عشان نحدث قايمة الـ Archived Orders
    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      context
          .read<OrderBloc>()
          .add(FetchArchivedOrdersEvent(userId: widget.userId));
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // نلغي الـ Timer لما الصفحة تتسكر
    super.dispose();
  }

  Future<void> _refreshArchivedOrders(BuildContext context) async {
    context
        .read<OrderBloc>()
        .add(FetchArchivedOrdersEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is FetchArchivedOrdersLoadingState) {
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
                  'Loading your archived orders...',
                  style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontSize: 18.sp,
                    color: MyTheme.mauveColor,
                  ),
                ),
              ],
            ),
          );
        } else if (state is FetchArchivedOrdersSuccessState) {
          final orders = state.archivedResponse.data ?? [];
          if (orders.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => _refreshArchivedOrders(context),
              color: MyTheme.orangeColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 200.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/images/order- 1745364975821.json',
                          width: 300.w,
                          height: 200.h,
                          fit: BoxFit.contain,
                          repeat: true,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'No archived orders',
                          style: MyTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: MyTheme.mauveColor,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Check back later!',
                          style:
                              MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                            fontSize: 16.sp,
                            color: MyTheme.grayColor2,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshArchivedOrders(context),
            color: MyTheme.orangeColor,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(
                          ordersId: order.ordersId ?? '',
                        ),
                      ),
                    );
                  },
                  child: _buildArchivedOrderCard(order),
                );
              },
            ),
          );
        } else if (state is FetchArchivedOrdersErrorState) {
          return RefreshIndicator(
            onRefresh: () => _refreshArchivedOrders(context),
            color: MyTheme.orangeColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/images/order- 1745364975821.json',
                        width: 300.w,
                        height: 200.h,
                        fit: BoxFit.contain,
                        repeat: true,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'No archived orders',
                        style:
                            MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.mauveColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Check back later!',
                        style:
                            MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          fontSize: 16.sp,
                          color: MyTheme.grayColor2,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildArchivedOrderCard(Data order) {
    return Container(
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
            blurRadius: 6.r,
            spreadRadius: 1.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Archived Order #${order.ordersId ?? 'N/A'}',
                style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.grayColor2,
                ),
              ),
              Text(
                order.ordersDatetime ?? 'N/A',
                style: MyTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: MyTheme.grayColor2,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Total: ${order.ordersTotalprice ?? '0.0'} EGP',
            style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
              fontSize: 12.sp,
              color: MyTheme.greenColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Delivery Fee: ${order.ordersPricedelivery ?? '0.0'} EGP',
            style: MyTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              color: MyTheme.grayColor2,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Address: ${order.addressStreet ?? 'N/A'}, ${order.addressCity ?? 'N/A'}',
            style: MyTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              color: MyTheme.grayColor2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            'Payment: ${order.ordersPaymentmethod == '0' ? 'Cash' : 'Card'}',
            style: MyTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              color: MyTheme.grayColor2,
            ),
          ),
        ],
      ),
    );
  }
}
