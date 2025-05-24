import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Main_Screen/main_screen.dart';
import 'package:graduation_project/Notification_Page/notification_manager.dart';
import 'package:graduation_project/Notification_Page/notification_screen.dart';
import 'package:graduation_project/Splash_Screen/splash_screen.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import 'package:graduation_project/auth/forget_password/check_email/check_email.dart';
import 'package:graduation_project/auth/forget_password/reset_password/ResetPassword.dart';
import 'package:graduation_project/home_screen/UI/Home_Page/home_screen.dart';
import 'package:graduation_project/home_screen/UI/Items_Page/Items_screen.dart';
import 'package:graduation_project/home_screen/UI/Category_Page/Services_Screen.dart';
import 'package:graduation_project/home_screen/UI/SpecialOfferCarouselWidget/offers_screen.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/UI/WishlistScreen.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteBloc.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/data/repo/FavoriteRepo.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Cart/cart_event.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/data/repo/cart_repo.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'package:graduation_project/auth/OTP/otp_screen.dart';
import 'package:graduation_project/auth/forget_password/OTP_Forget_Password/otp_screen.dart';
import 'package:graduation_project/auth/sign_up_screen/sign_up_screen.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';
import 'package:graduation_project/home_screen/UI/SearchFieldWidget/SearchScreen.dart';
import 'package:graduation_project/Profile_screen/UI/Profile/profile_screen.dart';
import 'package:graduation_project/Profile_screen/UI/Profile/edit_profile_screen.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_bloc.dart';
import 'package:graduation_project/Profile_screen/data/repo/Address_repo.dart';
import 'package:graduation_project/home_screen/UI/Cart_Page/order_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

// تعريف GlobalKey للـ Navigator
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Background message received: ${message.notification?.title}");
  await NotificationManager.saveNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioProvider.init();
  await AppLocalStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await NotificationManager.requestNotificationPermission();
  await NotificationManager.subscribeToTopics();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground message received: ${message.notification?.title}");
    NotificationManager.saveNotification(message);
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _tokenCheckTimer;

  @override
  void initState() {
    super.initState();
    // ابدأ تتبع التوكن
    startTokenCheckTimer();
  }

  void startTokenCheckTimer() {
    // تحقق كل دقيقة (60 ثانية)
    _tokenCheckTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (AppLocalStorage.isTokenExpired()) {
        // لو التوكن انتهى، اعملي logout
        AppLocalStorage.logout(navigatorKey.currentState!.context);
        // أوقفي الـ timer بعد الخروج
        _tokenCheckTimer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _tokenCheckTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int? userId =
        AppLocalStorage.getData('user_id'); // جلب user_id كـ int

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(
            create: (context) => CartBloc(cartRepo: CartRepo())
              ..add(userId != null
                  ? FetchCartEvent(userId: userId)
                  : FetchCartEvent(userId: 0)),
          ),
          BlocProvider(
            create: (context) => AddressBloc(AddressRepo()),
          ),
          BlocProvider(
              create: (context) => FavoriteBloc(favoriteRepo: FavoriteRepo())),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: MyTheme.lightTheme,
          initialRoute: SplashScreen.routName,
          routes: {
            SplashScreen.routName: (context) => const SplashScreen(),
            HomeScreen.routName: (context) => const HomeScreen(),
            MainScreen.routName: (context) => const MainScreen(),
            SignInScreen.routName: (context) => const SignInScreen(),
            SignUpScreen.routeName: (context) => const SignUpScreen(),
            OtpScreen.routName: (context) => OtpScreen(email: ''),
            SearchScreen.routeName: (context) => const SearchScreen(),
            OrdersScreen.routeName: (context) => const OrdersScreen(),
            OtpScreenForgetPassword.routName: (context) =>
                const OtpScreenForgetPassword(),
            ForgetPassword.routName: (context) => const ForgetPassword(),
            ResetPassword.routName: (context) {
              final String email =
                  ModalRoute.of(context)!.settings.arguments as String;
              return ResetPassword(email: email);
            },
            ServiceItemsScreen.routeName: (context) {
              final args = ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
              return ServiceItemsScreen(serviceId: args['serviceId']);
            },
            ProfileScreen.routeName: (context) => const ProfileScreen(),
            EditProfileScreen.routeName: (context) {
              final args = ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
              return EditProfileScreen(
                userId: args['userId'],
                profile: args['profile'],
              );
            },
            WishlistScreen.routeName: (context) => const WishlistScreen(),
            NotificationScreen.routeName: (context) =>
                const NotificationScreen(),
            OffersScreen.routeName: (context) => const OffersScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == ServicesScreen.routeName) {
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => ServicesScreen(
                  categoryId: args['categoryId'] as String,
                  categoryName: args['categoryName'] as String,
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
