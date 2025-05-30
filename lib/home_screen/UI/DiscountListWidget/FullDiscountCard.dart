import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';

class FullDiscountCard extends StatelessWidget {
  final dynamic item;

  const FullDiscountCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.h), // قللنا الـ margin من 10.h لـ 8.h
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(8.w), // قللنا الـ padding من 10.w لـ 8.w
        child: Row(
          children: [
            _buildImage(),
            SizedBox(width: 12.w), // قللنا من 15.w لـ 12.w
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 1 / 1, // نسبة 1:1 عشان الصورة تكون مربعة
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Image.network(
          item.itemsImage ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child:
                  Icon(Icons.broken_image, size: 30.w, color: Colors.grey[400]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // عشان الـ Column تاخد أقل مساحة
        children: [
          Text(
            item.itemsName ?? 'Unknown',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h), // قللنا من 5.h لـ 4.h
          Text(
            "${item.itemsPrice ?? 'N/A'} EGP",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          if (item.itemsDiscount != null && item.itemsDiscount != "0")
            Text(
              "${item.itemsDiscount}% OFF",
              style: TextStyle(
                fontSize: 12.sp,
                color: MyTheme.orangeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.star, size: 14.w, color: Colors.orangeAccent),
              SizedBox(width: 4.w),
              Text(
                item.serviceRating?.toString() ?? 'N/A',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
