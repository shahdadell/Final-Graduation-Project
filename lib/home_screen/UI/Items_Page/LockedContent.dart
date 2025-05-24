import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/sign_up_screen/sign_up_screen.dart';

class LockedContent extends StatelessWidget {
  const LockedContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[100]!, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_rounded, size: 60.w, color: MyTheme.orangeColor),
            SizedBox(height: 25.h),
            Text(
              'Unlock the Items!',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Please log in to explore',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
            ),
            SizedBox(height: 30.h),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              ),
              icon: Icon(Icons.login, size: 22.w, color: Colors.white),
              label: Text(
                'Sign Up Now',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
                backgroundColor: MyTheme.orangeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                elevation: 6,
                shadowColor: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
