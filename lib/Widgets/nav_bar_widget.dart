import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/UI/Home_Page/home_screen.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/UI/WishlistScreen.dart';
import 'package:graduation_project/home_screen/UI/Cart_Page/CartScreen.dart';
import 'package:graduation_project/home_screen/UI/Cart_Page/order_screen.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key, this.preIndex});
  final int? preIndex;

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.preIndex ?? 0;
  }

  final List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const WishlistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchHomeDataEvent(null)),
      child: Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: pages,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: MyTheme.whiteColor,
            boxShadow: [
              BoxShadow(
                color: MyTheme.grayColor3,
                blurRadius: 6,
                offset: const Offset(0, -1),
              ),
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: GNav(
              rippleColor: MyTheme.orangeColor.withOpacity(0.2),
              hoverColor: MyTheme.grayColor.withOpacity(0.1),
              haptic: true,
              tabBorderRadius: 15.r,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 300),
              gap: 6.w,
              color: MyTheme.grayColor2.withOpacity(0.7),
              activeColor: MyTheme.orangeColor2,
              iconSize: 22.w,
              tabBackgroundGradient: LinearGradient(
                colors: [
                  MyTheme.orangeColor.withOpacity(0.3),
                  MyTheme.orangeColor2.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              textStyle: GoogleFonts.dmSerifDisplay(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: MyTheme.orangeColor2,
              ),
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                  iconActiveColor: MyTheme.orangeColor2,
                  iconColor: MyTheme.grayColor2,
                ),
                GButton(
                  icon: Icons.shopping_cart_outlined,
                  text: 'Cart',
                  iconActiveColor: MyTheme.orangeColor2,
                  iconColor: MyTheme.grayColor2,
                ),
                GButton(
                  icon: Icons.list_alt_outlined,
                  text: 'Orders',
                  iconActiveColor: MyTheme.orangeColor2,
                  iconColor: MyTheme.grayColor2,
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Favorite',
                  iconActiveColor: MyTheme.orangeColor2,
                  iconColor: MyTheme.grayColor2,
                ),
              ],
              selectedIndex: currentPage,
              onTabChange: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
