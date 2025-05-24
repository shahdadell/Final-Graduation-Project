import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';

Widget buildProfileImage(String? imageUrl, bool isEditing) {
  return Stack(
    children: [
      Container(
        width: 130.w, // تكبير الصورة
        height: 120.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // border: Border.all(color: MyTheme.orangeColor2, width: 2.w), // تقليل سمك الـ border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // تقليل الـ shadow
              blurRadius: 8.r,
              spreadRadius: 1.r,
            ),
          ],
        ),
        child: ClipOval(
          child: imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  cacheWidth: 400, // تحسين جودة الصورة
                  cacheHeight: 400,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person,
                    size: 80.w, // تكبير الأيقونة الافتراضية
                    color: MyTheme.grayColor,
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.orangeColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                )
              : Icon(
                  Icons.person,
                  size: 80.w,
                  color: MyTheme.grayColor,
                ),
        ),
      ),
      if (isEditing)
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 25.r, // تكبير أيقونة الكاميرا
            backgroundColor: MyTheme.orangeColor,
            child:
                Icon(Icons.camera_alt, color: MyTheme.whiteColor, size: 25.w),
          ),
        ),
    ],
  );
}

Widget buildEditableField(
  BuildContext context,
  String label,
  TextEditingController controller,
  IconData icon, {
  bool isEditing = false,
  bool obscureText = false,
  TextInputType? keyboardType,
}) {
  final textTheme = Theme.of(context).textTheme;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: MyTheme.blackColor,
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 6.h),
        isEditing
            ? TextFormField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                style: textTheme.bodyMedium?.copyWith(
                  color: MyTheme.blackColor,
                  fontSize: 15.sp,
                ),
                decoration: InputDecoration(
                  hintText: label == 'Name'
                      ? 'e.g., John Doe'
                      : label == 'Email'
                          ? 'e.g., example@domain.com'
                          : 'e.g., +1234567890',
                  hintStyle: textTheme.bodySmall?.copyWith(
                    color: MyTheme.grayColor2.withOpacity(0.6),
                    fontSize: 13.sp,
                  ),
                  suffixIcon: Icon(
                    icon,
                    color: MyTheme.orangeColor,
                    size: 20.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: MyTheme.grayColor3.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: MyTheme.grayColor3.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: MyTheme.orangeColor,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.text,
                      style: textTheme.bodyMedium?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 15.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    icon,
                    color: MyTheme.orangeColor,
                    size: 20.w,
                  ),
                ],
              ),
      ],
    ),
  );
}
