import 'dart:async'; // أضيفي المكتبة دي عشان Polling
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../bloc/Cart/orders_bloc.dart';
import '../../bloc/Cart/orders_event.dart';
import '../../bloc/Cart/orders_state.dart';
import '../../data/model/orders_model_response/PendingResponse.dart';
import 'OrderDetailsScreen.dart';

class PendingOrdersScreen extends StatefulWidget {
  final int userId;

  const PendingOrdersScreen({super.key, required this.userId});

  @override
  _PendingOrdersScreenState createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // نبدأ Polling كل 30 ثانية عشان نحدث قايمة الـ Pending Orders
    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(Duration(minutes: 30), (timer) {
      context
          .read<OrderBloc>()
          .add(FetchPendingOrdersEvent(userId: widget.userId));
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // نلغي الـ Timer لما الصفحة تتسكر
    super.dispose();
  }

  Future<void> _refreshPendingOrders(BuildContext context) async {
    context
        .read<OrderBloc>()
        .add(FetchPendingOrdersEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is DeleteOrderSuccessState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: 'Success',
            desc: state.message,
            btnOkText: 'OK',
            btnOkColor: MyTheme.orangeColor,
            btnOkOnPress: () {},
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            titleTextStyle:
                MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: MyTheme.blackColor,
            ),
            descTextStyle: MyTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: MyTheme.grayColor2,
            ),
          ).show();
        } else if (state is DeleteOrderErrorState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'Error',
            desc: state.message,
            btnOkText: 'OK',
            btnOkColor: MyTheme.redColor,
            btnOkOnPress: () {},
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            titleTextStyle:
                MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: MyTheme.blackColor,
            ),
            descTextStyle: MyTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: MyTheme.grayColor2,
            ),
          ).show();
        }
      },
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is FetchPendingOrdersLoadingState) {
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
                    'Loading your pending orders...',
                    style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                      fontSize: 18.sp,
                      color: MyTheme.mauveColor,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FetchPendingOrdersSuccessState) {
            final orders = state.pendingResponse.data ?? [];
            if (orders.isEmpty) {
              return RefreshIndicator(
                onRefresh: () => _refreshPendingOrders(context),
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
                            'No pending orders',
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
                            style: MyTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
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
              onRefresh: () => _refreshPendingOrders(context),
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
                    child: _buildPendingOrderCard(order, context),
                  );
                },
              ),
            );
          } else if (state is FetchPendingOrdersErrorState) {
            return RefreshIndicator(
              onRefresh: () => _refreshPendingOrders(context),
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
                          'No pending orders',
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
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildPendingOrderCard(Data order, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(10.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pending Order #${order.ordersId ?? 'N/A'}',
                style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.mauveColor,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment: ${order.ordersPaymentmethod == '0' ? 'Cash' : 'Card'}',
                style: MyTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: MyTheme.grayColor2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.scale,
                    title: 'Delete Order',
                    desc:
                        'Are you sure you want to delete this order permanently?',
                    btnCancelText: 'Cancel',
                    btnOkText: 'Delete',
                    btnCancelColor: MyTheme.grayColor2,
                    btnOkColor: MyTheme.redColor,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      context.read<OrderBloc>().add(
                            DeleteOrderEvent(
                              orderId: order.ordersId ?? '',
                              userId: widget.userId,
                            ),
                          );
                    },
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    titleTextStyle:
                        MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.blackColor,
                    ),
                    descTextStyle:
                        MyTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      color: MyTheme.grayColor2,
                    ),
                  ).show();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: MyTheme.redColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'Delete',
                    style: MyTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: MyTheme.redColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
