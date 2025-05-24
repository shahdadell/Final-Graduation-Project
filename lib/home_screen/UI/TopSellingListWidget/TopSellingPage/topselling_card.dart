import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/data/model/topSelling_model_response/TopSellinModelResponse.dart';
import 'item_details_dialog.dart'; // تأكدي إن showItemDetailsDialogTopSelling موجود هنا

Widget buildTopCard(BuildContext context, dynamic item) {
  // التأكد إن item من نوع TopSellingData
  if (item is! TopSellingData) {
    print("Error: Item is not of type TopSellingData");
    return SizedBox.shrink(); // لو النوع غلط، نرجع حاجة فاضية
  }

  // تحويل البيانات من String لـ double بأمان
  double originalPrice = double.tryParse(item.itemsPrice ?? '0') ?? 0.0;
  double discount = (double.tryParse(item.itemsDiscount ?? '0') ?? 0.0) / 100;
  double discountedPrice = originalPrice * (1 - discount);

  return GestureDetector(
    onTap: () {
      print("Card tapped: ${item.itemsName}");
      showItemDetailsDialogTopSelling(context, item);
    },
    child: Container(
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
                          decoration:
                              discount > 0 ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      if (discount > 0)
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
                  if (discount > 0)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        '-${(discount * 100).toStringAsFixed(0)}% OFF',
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
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                if (kDebugMode) {
                  print("Details button tapped: ${item.itemsName}");
                }
                showItemDetailsDialogTopSelling(context, item);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: MyTheme.orangeColor,
                  borderRadius: BorderRadius.circular(10.r),
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
