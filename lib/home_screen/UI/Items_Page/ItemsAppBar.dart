import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';

class ItemsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ItemsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Icon(
            Icons.arrow_back_ios,
            color: MyTheme.whiteColor,
            size: 24.w,
          ),
        ),
      ),
      title: Text(
        "Items",
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

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
