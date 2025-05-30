import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Notification_Page/notification_manager.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';
import 'package:graduation_project/home_screen/UI/Home_Page/home_screen.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = 'NotificationScreen';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // لو المستخدم guest، اعرضي SnackBar وامنعي الوصول للإشعارات
    if (AppLocalStorage.isGuest()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please log in to view notifications'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushReplacementNamed(context, SignInScreen.routName);
      });
      return const SizedBox.shrink(); // شاشة فاضية مؤقتًا لحد ما يحصل redirect
    }

    return Scaffold(
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
          "Notifications",
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
        ).animate().fadeIn(duration: 400.ms).slideY(
              begin: 0.1,
              end: 0.0,
              duration: 400.ms,
              curve: Curves.easeOut,
            ),
        centerTitle: true,
        backgroundColor: MyTheme.orangeColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: NotificationManager.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.orangeColor,
                strokeWidth: 3.w,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/images/No Notifacation.json',
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'No Notifications',
                    style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.mauveColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Check back later for updates!',
                    style: MyTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontSize: 16.sp,
                      color: MyTheme.grayColor2,
                    ),
                  ),
                  SizedBox(height: 20.h),

                ],
              ),
            );
          }

          final notifications = snapshot.data!;
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            itemCount: notifications.length,
            separatorBuilder: (context, index) => Divider(
              color: MyTheme.grayColor.withOpacity(0.2),
              height: 1.h,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 6.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyTheme.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: MyTheme.grayColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    leading: _buildLeadingIcon(),
                    title: Text(
                      notification.title ?? 'No Title',
                      style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.mauveColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            notification.body ?? 'No Body',
                            style: MyTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              fontSize: 14.sp,
                              color: MyTheme.grayColor2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          notification.timestamp?.toString() ?? 'Just now',
                          style:
                              MyTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            color: MyTheme.grayColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: 300.ms,
                    delay: (index * 100).ms,
                    curve: Curves.easeOut,
                  )
                  .slideX(
                    begin: 0.2,
                    end: 0.0,
                    duration: 300.ms,
                    curve: Curves.easeOut,
                  );
            },
          );
        },
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: MyTheme.orangeColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.notifications_rounded,
        color: MyTheme.orangeColor,
        size: 24.w,
      ),
    );
  }
}
