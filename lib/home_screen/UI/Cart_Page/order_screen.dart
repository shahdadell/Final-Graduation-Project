import 'dart:async'; // أضيفي المكتبة دي عشان Polling
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import '../../bloc/Cart/orders_bloc.dart';
import '../../bloc/Cart/orders_event.dart';
import '../../data/repo/orders_repo.dart';
import 'ArchivedOrdersScreen.dart';
import 'PendingOrdersScreen.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = 'order';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late OrderBloc _orderBloc;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _orderBloc = OrderBloc(orderRepo: OrderRepo());
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId != null) {
      _orderBloc.add(FetchPendingOrdersEvent(userId: userId));
      // نبدأ Polling كل 30 ثانية عشان نحدث القوايم
      _startPolling(userId);
    }

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging && userId != null) {
        if (_tabController.index == 0) {
          _orderBloc.add(FetchPendingOrdersEvent(userId: userId));
        } else if (_tabController.index == 1) {
          _orderBloc.add(FetchArchivedOrdersEvent(userId: userId));
        }
      }
    });
  }

  void _startPolling(int userId) {
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      // نحدث القايمتين بناءً على الـ Tab الحالي
      if (_tabController.index == 0) {
        _orderBloc.add(FetchPendingOrdersEvent(userId: userId));
      } else if (_tabController.index == 1) {
        _orderBloc.add(FetchArchivedOrdersEvent(userId: userId));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // نلغي الـ Timer لما الصفحة تتسكر
    _tabController.dispose();
    _orderBloc.close();
    super.dispose();
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
                Icon(
                  Icons.lock_rounded,
                  size: 80.w,
                  color: MyTheme.mauveColor.withOpacity(0.7),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Please log in to view your orders',
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
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.orangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                    elevation: 5,
                    shadowColor: MyTheme.orangeColor.withOpacity(0.4),
                  ),
                  child: Text(
                    'Login',
                    style: MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => _orderBloc,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: TabBar(
                controller: _tabController,
                labelColor: MyTheme.orangeColor,
                unselectedLabelColor: MyTheme.grayColor2.withOpacity(0.7),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: MyTheme.orangeColor,
                    width: 3.0,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 30.w),
                ),
                labelStyle: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle:
                    MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                tabs: const [
                  Tab(text: 'Pending'),
                  Tab(text: 'Archived'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PendingOrdersScreen(userId: userId),
                  ArchivedOrdersScreen(userId: userId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Your Orders",
        style: MyTheme.lightTheme.textTheme.displayLarge?.copyWith(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: MyTheme.grayColor3,
              blurRadius: 3.r,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: MyTheme.orangeColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.r),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      ),
    );
  }
}
