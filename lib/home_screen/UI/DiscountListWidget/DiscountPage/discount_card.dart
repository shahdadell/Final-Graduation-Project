import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'item_details_dialog.dart';

Widget buildDiscountCard(BuildContext context, dynamic item) {
  double originalPrice = (item.itemsPrice ?? 0.0).toDouble();
  double discount = (item.itemsDiscount ?? 0) / 100;
  double discountedPrice = originalPrice * (1 - discount);

  return GestureDetector(
    onTap: () {
      if (kDebugMode) {
        print("Card tapped: ${item.itemsName}");
      }
      showItemDetailsDialog(context, item);
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        // border: Border.all(
        //   color: MyTheme.orangeColor, // لون البوردر
        //   width: 1,        // سمك البوردر
        // ),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8.r,
            spreadRadius: 2.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
            child: item.itemsImage != null && item.itemsImage!.isNotEmpty
                ? Image.network(
                    item.itemsImage!,
                    height: 100.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100.h,
                        width: 100.w,
                        color: Colors.grey[200],
                        child: Icon(Icons.broken_image,
                            size: 40.w, color: Colors.grey[400]),
                      );
                    },
                  )
                : Container(
                    height: 100.h,
                    width: 100.w,
                    color: Colors.grey[200],
                    child: Icon(Icons.broken_image,
                        size: 40.w, color: Colors.grey[400]),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.itemsName ?? 'No Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        '${originalPrice.toStringAsFixed(2)} EGP',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${discountedPrice.toStringAsFixed(2)} EGP',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (item.itemsDiscount != null && item.itemsDiscount != 0)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        '-${item.itemsDiscount.toStringAsFixed(0)}% OFF',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // زرار أشيك في الجنب
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                print("Details button tapped: ${item.itemsName}");
                showItemDetailsDialog(context, item);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: MyTheme.orangeColor,
                  // gradient: const LinearGradient(
                  //   colors: [Colors.orange, Colors.deepOrange],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                  borderRadius: BorderRadius.circular(10.r),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.orange.withOpacity(0.4),
                  //     blurRadius: 6.r,
                  //     spreadRadius: 1.r,
                  //     offset: Offset(0, 2.h),
                  //   ),
                  // ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 14.w,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
