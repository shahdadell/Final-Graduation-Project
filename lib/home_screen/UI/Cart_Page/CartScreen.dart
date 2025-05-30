import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Profile_screen/UI/Addresses/add_address_screen.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_state.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_event.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_state.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../bloc/Cart/orders_bloc.dart';
import '../../bloc/Cart/orders_event.dart';
import '../../bloc/Cart/orders_state.dart';
import '../../data/model/Cart_model_response/CartViewResponse.dart';
import '../../data/model/Cart_model_response/datacart.dart';
import '../../data/repo/orders_repo.dart';
import 'order_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? selectedAddressId;
  int paymentMethod = 0;
  bool isDialogShown = false;
  bool hasNavigatedToAddAddress = false; // للتحكم في التوجيه لصفحة إضافة العنوان
  final TextEditingController _couponController = TextEditingController();
  int? couponId;
  double couponDiscount = 0.0;
  bool isCouponApplied = false;

  @override
  void initState() {
    super.initState();
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId != null) {
      context.read<AddressBloc>().add(FetchAddressesEvent());
      context.read<CartBloc>().add(FetchCartEvent(userId: userId));
    }
  }

  @override
  void didUpdateWidget(CartScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId != null) {
      context.read<CartBloc>().add(FetchCartEvent(userId: userId));
    }
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  Future<void> _refreshCart(BuildContext context) async {
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId != null) {
      context.read<CartBloc>().add(FetchCartEvent(userId: userId));
    }
  }

  void _showErrorDialog(String message) {
    if (isDialogShown) return;
    setState(() {
      isDialogShown = true;
    });
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Error',
      desc: message,
      btnOkText: 'OK',
      btnOkColor: MyTheme.redColor,
      btnOkOnPress: () {
        setState(() {
          isDialogShown = false;
        });
      },
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      titleTextStyle: MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
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
                  'Please log in to view your cart',
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderBloc(orderRepo: OrderRepo()),
        ),
      ],
      child: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is FetchCartSuccessState) {
            AppLocalStorage.cacheCart(state.cartViewResponse.toJson());
          } else if (state is DeleteCartItemSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: MyTheme.whiteColor, size: 16.w),
                    SizedBox(width: 8.w),
                    Text('Item removed from cart'),
                  ],
                ),
                backgroundColor: MyTheme.greenColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            context.read<CartBloc>().add(FetchCartEvent(userId: userId));
          } else if (state is DeleteCartItemErrorState) {
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
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is AddToCartSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: MyTheme.whiteColor, size: 16.w),
                    SizedBox(width: 8.w),
                    Text('Quantity updated!'),
                  ],
                ),
                backgroundColor: MyTheme.greenColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            context.read<CartBloc>().add(FetchCartEvent(userId: userId));
          } else if (state is AddToCartErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_rounded,
                        color: MyTheme.whiteColor, size: 16.w),
                    SizedBox(width: 8.w),
                    Text('Failed to update quantity: ${state.message}'),
                  ],
                ),
                backgroundColor: MyTheme.redColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is CheckCouponSuccessState) {
            setState(() {
              couponId =
                  int.tryParse(state.couponResponse.data?.couponId ?? '0');
              couponDiscount = double.tryParse(
                  state.couponResponse.data?.couponDiscount ?? '0.0') ??
                  0.0;
              isCouponApplied = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: MyTheme.whiteColor, size: 16.w),
                    SizedBox(width: 8.w),
                    Text('Coupon applied successfully!'),
                  ],
                ),
                backgroundColor: MyTheme.greenColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            context.read<CartBloc>().add(FetchCartEvent(userId: userId));
          } else if (state is CheckCouponErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_rounded,
                        color: MyTheme.whiteColor, size: 16.w),
                    SizedBox(width: 8.w),
                    Text('Failed to apply coupon: ${state.message}'),
                  ],
                ),
                backgroundColor: MyTheme.redColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            setState(() {
              couponId = null;
              couponDiscount = 0.0;
              isCouponApplied = false;
              _couponController.clear();
            });
          }
        },
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is CheckoutSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: MyTheme.whiteColor, size: 16.w),
                      SizedBox(width: 8.w),
                      Text('Order placed successfully!'),
                    ],
                  ),
                  backgroundColor: MyTheme.greenColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrdersScreen(),
                ),
              );
              context.read<CartBloc>().add(FetchCartEvent(userId: userId));
              setState(() {
                couponId = null;
                couponDiscount = 0.0;
                isCouponApplied = false;
                _couponController.clear();
              });
            } else if (state is CheckoutErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.error_rounded,
                          color: MyTheme.whiteColor, size: 16.w),
                      SizedBox(width: 8.w),
                      Text('Checkout failed: ${state.message}'),
                    ],
                  ),
                  backgroundColor: MyTheme.redColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
              color: MyTheme.whiteColor,
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is FetchCartLoadingState) {
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
                            'Loading your cart...',
                            style: MyTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                              fontSize: 18.sp,
                              color: MyTheme.mauveColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is FetchCartSuccessState) {
                    final cart = state.cartViewResponse;
                    if (cart.status == 'success') {
                      final restCafeItems = cart.restCafe?.datacart ?? [];
                      final hotelTouristItems =
                          cart.hotelTourist?.datacart ?? [];
                      final offerItems = cart.offers ?? [];
                      final allItems = [
                        ...restCafeItems,
                        ...hotelTouristItems,
                        ...offerItems
                      ];
                      if (allItems.isNotEmpty) {
                        return RefreshIndicator(
                          onRefresh: () => _refreshCart(context),
                          color: MyTheme.orangeColor,
                          child:
                          _buildCartList(context, allItems, userId, cart),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () => _refreshCart(context),
                        color: MyTheme.orangeColor,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: _buildEmptyCart(context),
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () => _refreshCart(context),
                      color: MyTheme.orangeColor,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: _buildEmptyCart(context),
                      ),
                    );
                  } else if (state is FetchCartErrorState) {
                    return RefreshIndicator(
                      onRefresh: () => _refreshCart(context),
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
                                  style: MyTheme
                                      .lightTheme.textTheme.titleMedium
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
                                        .read<CartBloc>()
                                        .add(FetchCartEvent(userId: userId));
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
                          'Loading your cart...',
                          style:
                          MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                            fontSize: 18.sp,
                            color: MyTheme.mauveColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Your Cart",
        style: MyTheme.lightTheme.textTheme.displayLarge?.copyWith(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: MyTheme.grayColor3,
              blurRadius: 3.r,
              offset: Offset(1, 1),
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
    );
  }

  Widget _buildCartList(BuildContext context, List<Datacart> dataCart,
      int userId, CartViewResponse cart) {
    double totalPrice = calculateTotalPrice(cart);
    double discountedPrice = totalPrice - (totalPrice * (couponDiscount / 100));

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
            itemCount: dataCart.length,
            itemBuilder: (context, index) {
              final item = dataCart[index];
              final String type = item.cartType == 'offer' ? 'offer' : 'item';

              return BlocConsumer<CartBloc, CartState>(
                listener: (context, state) {
                  if (state is DeleteCartItemSuccessState) {
                    // مفيش حاجة محتاجة تتعمل هنا لأن FetchCartEvent هيحدث الـ state
                  }
                },
                builder: (context, state) {
                  bool isLoading = state is DeleteCartItemLoadingState ||
                      state is AddToCartLoadingState;
                  double itemPrice =
                      double.tryParse(item.price ?? item.itemsPrice ?? '0.0') ??
                          0.0;
                  int itemQuantity =
                      int.tryParse(item.cartQuantity ?? '0') ?? 0;
                  double totalItemPrice = itemPrice * itemQuantity;

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
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: item.image != null || item.itemsImage != null
                              ? CachedNetworkImage(
                            imageUrl: item.image ?? item.itemsImage!,
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
                            errorWidget: (context, url, error) => Icon(
                              Icons.fastfood_rounded,
                              size: 24.w,
                              color: MyTheme.orangeColor,
                            ),
                          )
                              : Icon(
                            Icons.fastfood_rounded,
                            size: 24.w,
                            color: MyTheme.orangeColor,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name ?? item.itemsName ?? 'No Name',
                                style: MyTheme.lightTheme.textTheme.titleSmall
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
                                '${itemPrice.toStringAsFixed(2)} EGP',
                                style: MyTheme.lightTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  fontSize: 12.sp,
                                  color: MyTheme.greenColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Qty: $itemQuantity',
                                style: MyTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  fontSize: 12.sp,
                                  color: MyTheme.grayColor2,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Total: ${totalItemPrice.toStringAsFixed(2)} EGP',
                                style: MyTheme.lightTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  fontSize: 12.sp,
                                  color: MyTheme.greenColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (item.cartItemsid != null &&
                                      (int.tryParse(item.cartQuantity ?? '0') ??
                                          0) >
                                          1) {
                                    context
                                        .read<CartBloc>()
                                        .add(DeleteCartItemEvent(
                                      userId: userId,
                                      itemId: int.parse(item.cartItemsid!),
                                      type: type,
                                    ));
                                  } else if (item.cartItemsid != null) {
                                    context
                                        .read<CartBloc>()
                                        .add(DeleteCartItemEvent(
                                      userId: userId,
                                      itemId: int.parse(item.cartItemsid!),
                                      type: type,
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Cannot decrease quantity: Missing item ID'),
                                        backgroundColor: Colors.redAccent,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: MyTheme.orangeColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Icon(
                                    Icons.remove_rounded,
                                    size: 18.w,
                                    color: MyTheme.orangeColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                item.cartQuantity ?? '0',
                                style: MyTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: MyTheme.mauveColor,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              GestureDetector(
                                onTap: () {
                                  if (item.cartItemsid != null) {
                                    context.read<CartBloc>().add(AddToCartEvent(
                                      userId: userId,
                                      itemId: int.parse(item.cartItemsid!),
                                      quantity: 1,
                                      type: type,
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Cannot increase quantity: Missing item ID'),
                                        backgroundColor: Colors.redAccent,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: MyTheme.orangeColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Icon(
                                    Icons.add_rounded,
                                    size: 18.w,
                                    color: MyTheme.orangeColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              GestureDetector(
                                onTap: isLoading
                                    ? null
                                    : () {
                                  if (item.cartItemsid != null) {
                                    context.read<CartBloc>().add(
                                      DeleteCartItemEvent(
                                        userId: userId,
                                        itemId: int.parse(
                                            item.cartItemsid!),
                                        type: type,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Cannot remove item: Missing item ID'),
                                        backgroundColor: Colors.redAccent,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: MyTheme.redColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: isLoading
                                      ? SizedBox(
                                    width: 16.w,
                                    height: 16.w,
                                    child: CircularProgressIndicator(
                                      color: MyTheme.redColor,
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
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: MyTheme.mauveColor.withOpacity(0.1),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isCouponApplied) ...[
                        Text(
                          'Original: ${totalPrice.toStringAsFixed(2)} EGP',
                          style: MyTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontSize: 14.sp,
                            color: MyTheme.grayColor2,
                            decoration: TextDecoration.lineThrough,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'After Discount: ${discountedPrice.toStringAsFixed(2)} EGP',
                          style: MyTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: MyTheme.greenColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ] else ...[
                        Text(
                          '${totalPrice.toStringAsFixed(2)} EGP',
                          style: MyTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: MyTheme.greenColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: MyTheme.orangeColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_cart_rounded,
                        size: 18.w,
                        color: MyTheme.orangeColor,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${dataCart.length} Item${dataCart.length != 1 ? 's' : ''}',
                        style:
                        MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.orangeColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Address',
                      style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.mauveColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // التوجيه لصفحة إضافة عنوان جديد
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddAddressScreen(),
                          ),
                        );
                        // بعد الرجوع، نحدّث قائمة العناوين
                        if (result == true) { // لو العنوان اتضاف بنجاح
                          context.read<AddressBloc>().add(FetchAddressesEvent());
                        }
                      },
                      child: Text(
                        'Add New Address',
                        style: MyTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          color: MyTheme.orangeColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, addressState) {
                    if (addressState is FetchAddressesLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: MyTheme.orangeColor),
                      );
                    } else if (addressState is FetchAddressesSuccessState) {
                      final addresses = addressState.viewAddresses.data ?? [];
                      if (addresses.isEmpty && !hasNavigatedToAddAddress) {
                        WidgetsBinding.instance.addPostFrameCallback((_) async {
                          setState(() {
                            hasNavigatedToAddAddress = true;
                          });
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddAddressScreen(),
                            ),
                          );
                          // بعد الرجوع، نحدّث قائمة العناوين
                          if (result == true) { // لو العنوان اتضاف بنجاح
                            context.read<AddressBloc>().add(FetchAddressesEvent());
                          }
                        });
                        return Center(
                          child: Text(
                            'Redirecting to add a new address...',
                            style: MyTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              fontSize: 12.sp,
                              color: MyTheme.grayColor2,
                            ),
                          ),
                        );
                      } else if (addresses.isEmpty) {
                        return Center(
                          child: Text(
                            'No addresses found. Please add an address.',
                            style: MyTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              fontSize: 12.sp,
                              color: MyTheme.grayColor2,
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: addresses.map((address) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 4.h),
                            decoration: BoxDecoration(
                              color: MyTheme.whiteColor,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: selectedAddressId == address.addressId
                                    ? MyTheme.orangeColor
                                    : MyTheme.grayColor.withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                  blurRadius: 6.r,
                                  spreadRadius: 1.r,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: RadioListTile(
                              value: address.addressId,
                              groupValue: selectedAddressId,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddressId = value.toString();
                                });
                              },
                              activeColor: MyTheme.orangeColor,
                              title: Text(
                                address.addressName ?? 'No Name',
                                style: MyTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${address.addressStreet ?? ''}, ${address.addressCity ?? ''}\nPhone: ${address.addressPhone ?? 'No Phone'}',
                                style: MyTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: MyTheme.grayColor2,
                                  fontSize: 10.sp,
                                ),
                              ),
                              secondary: Icon(
                                Icons.location_on,
                                color: MyTheme.orangeColor,
                                size: 18.w,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else if (addressState is FetchAddressesErrorState) {
                      return Center(
                        child: Text(
                          'Error loading addresses: ${addressState.message}',
                          style:
                          MyTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12.sp,
                            color: MyTheme.redColor,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.mauveColor,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  decoration: BoxDecoration(
                    color: MyTheme.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: MyTheme.grayColor3.withOpacity(0.3),
                        blurRadius: 6.r,
                        spreadRadius: 1.r,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        value: 0,
                        groupValue: paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            paymentMethod = value as int;
                          });
                        },
                        activeColor: MyTheme.orangeColor,
                        title: Text(
                          'Cash on Delivery',
                          style: MyTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        secondary: Icon(
                          Icons.money,
                          color: MyTheme.greenColor,
                          size: 18.w,
                        ),
                      ),
                      RadioListTile(
                        value: 1,
                        groupValue: paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            paymentMethod = value as int;
                          });
                        },
                        activeColor: MyTheme.orangeColor,
                        title: Text(
                          'Credit/Debit Card',
                          style: MyTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        secondary: Icon(
                          Icons.credit_card,
                          color: MyTheme.blueColor,
                          size: 18.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apply Coupon',
                  style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.mauveColor,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _couponController,
                        style: TextStyle(fontSize: 12.sp),
                        decoration: InputDecoration(
                          hintText: "Enter coupon code",
                          hintStyle: TextStyle(
                              color: MyTheme.grayColor2, fontSize: 12.sp),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 8.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: MyTheme.orangeColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                                color: MyTheme.orangeColor, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                                color: MyTheme.grayColor.withOpacity(0.3)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton(
                      onPressed: () {
                        if (_couponController.text.isNotEmpty) {
                          context.read<CartBloc>().add(
                            CheckCouponEvent(
                                couponName: _couponController.text),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter a coupon code"),
                              backgroundColor: MyTheme.redColor,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.orangeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 8.h),
                      ),
                      child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CheckCouponLoadingState) {
                            return SizedBox(
                              width: 16.w,
                              height: 16.h,
                              child: CircularProgressIndicator(
                                color: MyTheme.whiteColor,
                                strokeWidth: 2.w,
                              ),
                            );
                          }
                          return Text(
                            isCouponApplied ? 'Applied' : 'Apply',
                            style: MyTheme.lightTheme.textTheme.displayMedium
                                ?.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                if (isCouponApplied)
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Coupon Applied: ${couponDiscount}% off',
                          style:
                          MyTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12.sp,
                            color: MyTheme.greenColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              couponId = null;
                              couponDiscount = 0.0;
                              isCouponApplied = false;
                              _couponController.clear();
                            });
                          },
                          child: Text(
                            'Remove',
                            style: MyTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              fontSize: 12.sp,
                              color: MyTheme.redColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              bool isLoading = state is CheckoutLoadingState;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                    if (selectedAddressId == null) {
                      _showErrorDialog(
                          'Please select a delivery address.');
                      return;
                    }
                    int orderstype = 1;
                    double priceDelivery = 10.0;
                    double ordersPrice = calculateTotalPrice(cart);
                    double finalPrice = ordersPrice -
                        (ordersPrice * (couponDiscount / 100));

                    context.read<OrderBloc>().add(CheckoutEvent(
                      userId: userId,
                      addressId: int.parse(selectedAddressId!),
                      orderstype: orderstype,
                      priceDelivery: priceDelivery,
                      ordersPrice: finalPrice,
                      couponId: couponId,
                      paymentMethod: paymentMethod,
                      couponDiscount: couponDiscount,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.orangeColor,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 5,
                    shadowColor: MyTheme.orangeColor.withOpacity(0.5),
                  ),
                  child: isLoading
                      ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: CircularProgressIndicator(
                      color: MyTheme.whiteColor,
                      strokeWidth: 2.w,
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payment_rounded,
                        size: 18.w,
                        color: MyTheme.whiteColor,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Place Order (${(totalPrice - (totalPrice * (couponDiscount / 100))).toStringAsFixed(2)} EGP)',
                        style: MyTheme.lightTheme.textTheme.displayMedium
                            ?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/cart- 1745364559641.json',
              width: 200.w,
              height: 200.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20.h),
            Text(
              'Your cart is empty',
              style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: MyTheme.mauveColor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Start adding items now!',
              style: MyTheme.lightTheme.textTheme.titleSmall
                  ?.copyWith(fontSize: 16.sp, color: MyTheme.grayColor2),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  double calculateTotalPrice(CartViewResponse cart) {
    double totalPrice = 0.0;
    final restCafeItems = cart.restCafe?.datacart ?? [];
    final hotelTouristItems = cart.hotelTourist?.datacart ?? [];
    final offerItems = cart.offers ?? [];
    final allItems = [...restCafeItems, ...hotelTouristItems, ...offerItems];

    for (var item in allItems) {
      double price =
          double.tryParse(item.price ?? item.itemsPrice ?? '0.0') ?? 0.0;
      int quantity = int.tryParse(item.cartQuantity ?? '0') ?? 0;
      totalPrice += price * quantity;
    }

    return totalPrice;
  }
}