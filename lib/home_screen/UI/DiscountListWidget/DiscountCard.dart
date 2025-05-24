import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'DiscountPage/item_details_dialog.dart';

class DiscountCard extends StatelessWidget {
  final dynamic item;

  const DiscountCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print("Discount Card tapped: ${item.itemsName}");
        }
        showItemDetailsDialog(context, item);
      },
      child: Container(
        width: 140.w,
        margin: EdgeInsets.symmetric(
            horizontal: 8.w, vertical: 2.h), // قللنا الـ margin الرأسي
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // عشان الـ Column تاخد أقل مساحة
          children: [
            _buildImage(),
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9, // نسبة عرض لارتفاع مناسبة للصور
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.network(
              item.itemsImage ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.broken_image,
                      size: 30.w, color: Colors.grey[400]),
                );
              },
            ),
          ),
        ),
        if (item.itemsDiscount != null && item.itemsDiscount != 0)
          Positioned(
            top: 6.h,
            left: 6.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                "${item.itemsDiscount}% OFF",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: EdgeInsets.all(4.w), // قللنا الـ padding من 6.w لـ 4.w
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.itemsName ?? 'Unknown',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.h), // قللنا من 3.h لـ 2.h
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${item.itemsPrice ?? 'N/A'} EGP",
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 12.w, color: Colors.orangeAccent),
                  SizedBox(width: 3.w),
                  Text(
                    item.serviceRating?.toString() ?? 'N/A',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
