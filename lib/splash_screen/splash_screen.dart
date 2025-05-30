import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduation_project/Main_Screen/main_screen.dart';
import 'package:graduation_project/Widgets/nav_bar_widget.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

class SplashScreen extends StatelessWidget {
  static const String routName = "SplashScreen";
  const SplashScreen({super.key});

  // دالة لفحص الـ Token
  Future<bool> _checkToken() async {
    final token = AppLocalStorage.getData('token');
    final tokenTimestamp = AppLocalStorage.getData('token_timestamp');

    if (token == null || tokenTimestamp == null) {
      return false; // مفيش Token، يروح للـ MainScreen
    }

    // احسب الفرق بين الوقت الحالي ووقت تخزين الـ Token
    DateTime tokenTime = DateTime.fromMillisecondsSinceEpoch(tokenTimestamp);
    Duration difference = DateTime.now().difference(tokenTime);

    // لو الفرق أقل من ساعتين (2 * 60 * 60 = 7200 ثانية)، الـ Token صالح
    if (difference.inSeconds < 7200) {
      return true; // الـ Token صالح، يروح للـ NavBarWidget
    } else {
      // لو الـ Token انتهت مدته، امسحيه وارجع false
      await AppLocalStorage.removeData('token');
      await AppLocalStorage.removeData('token_timestamp');
      await AppLocalStorage.removeData('user_id');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () async {
        if (context.mounted) {
          // افحص الـ Token
          bool isTokenValid = await _checkToken();

          // انتقل بناءً على النتيجة
          if (isTokenValid) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NavBarWidget()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          }
        }
      });
    });

    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Image.asset(
        "assets/images/copy.gif",
        width: mediaQuery.width,
        height: mediaQuery.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
