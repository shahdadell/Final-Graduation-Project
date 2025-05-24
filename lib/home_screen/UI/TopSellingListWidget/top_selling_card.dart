import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'TopSellingPage/item_details_dialog.dart';

Widget buildTopSellingCard(BuildContext context, dynamic item) {
  return GestureDetector(
    onTap: () {
      if (kDebugMode) {
        print("Top Selling Card tapped: ${item.itemsName}");
      }
      showItemDetailsDialogTopSelling(context, item); // استدعاء الـ Dialog
    },
    child: Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6.r,
            spreadRadius: 1.r,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.network(
              item.itemsImage ?? '',
              height: 200.h,
              width: 160.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Icon(
                    Icons.fastfood,
                    size: 50.w,
                    color: Colors.grey[500],
                  ),
                );
              },
            ),
          ),
          // Overlay للتفاصيل
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.2),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemsName ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${item.itemsPrice ?? 'N/A'} EGP",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: MyTheme.orangeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14.w,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "4.5", // لو فيه rating ديناميكي، استبدليه هنا
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Discount Badge
          if (item.itemsDiscount != null && item.itemsDiscount != "0")
            Positioned(
              top: 10.h,
              left: 10.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.r,
                      spreadRadius: 1.r,
                    ),
                  ],
                ),
                child: Text(
                  "${item.itemsDiscount}% OFF",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
