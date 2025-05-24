import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/UI/SearchFieldWidget/ItemDetailsPage.dart';
import 'package:graduation_project/home_screen/UI/Items_Page/Items_screen.dart'; // استيراد ServiceItemsScreen
import 'package:graduation_project/home_screen/data/model/search_model_response/SearchModelResponse.dart'
    as searchModel;
import 'package:graduation_project/local_data/shared_preference.dart'; // استيراد AppLocalStorage

class SearchResultCard extends StatelessWidget {
  final searchModel.Data service;

  const SearchResultCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final int? userId = AppLocalStorage.getData('user_id') ?? 10; // جلب userId
    final serviceId =
        int.tryParse(service.serviceId ?? '0') ?? 0; // تحويل serviceId لـ int

    return GestureDetector(
      onTap: () {
        // التنقل لـ ServiceItemsScreen مع تمرير serviceId و userId
        Navigator.pushNamed(
          context,
          ServiceItemsScreen.routeName,
          arguments: {
            'serviceId': serviceId,
            'userId': userId,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: MyTheme.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
          border:
              Border.all(color: MyTheme.blueColor.withOpacity(0.3), width: 1.w),
          boxShadow: [
            BoxShadow(
              color: MyTheme.blackColor.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  service.serviceImage ?? '',
                  width: 60.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60.w,
                    height: 50.h,
                    color: MyTheme.grayColor.withOpacity(0.2),
                    child: Icon(Icons.error,
                        size: 20.sp, color: MyTheme.grayColor2),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      service.serviceName ?? 'Not Available',
                      style: textTheme.titleMedium?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      service.serviceDescription ?? 'No Description',
                      style: textTheme.bodySmall?.copyWith(
                        color: MyTheme.grayColor2,
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: MyTheme.yellowColor, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(
                              service.serviceRating ?? '0.0',
                              style: textTheme.titleSmall?.copyWith(
                                color: MyTheme.orangeColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: service.serviceActive == "1"
                                ? MyTheme.greenColor.withOpacity(0.2)
                                : MyTheme.redColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            service.serviceActive == "1"
                                ? 'Available'
                                : 'Not Available',
                            style: textTheme.bodySmall?.copyWith(
                              color: service.serviceActive == "1"
                                  ? MyTheme.greenColor
                                  : MyTheme.redColor,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemResultCard extends StatelessWidget {
  final searchModel.ItemData item;

  const ItemResultCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    double price = double.tryParse(item.itemsPrice ?? '0') ?? 0.0;
    double discount = double.tryParse(item.itemsDiscount ?? '0') ?? 0.0;
    double discountedPrice = price - discount;

    return GestureDetector(
      onTap: () {
        // الانتقال إلى صفحة التفاصيل
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailsPage(item: item),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: MyTheme.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
          border:
              Border.all(color: MyTheme.blueColor.withOpacity(0.3), width: 1.w),
          boxShadow: [
            BoxShadow(
              color: MyTheme.blackColor.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  item.itemsImage ?? '',
                  width: 60.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60.w,
                    height: 50.h,
                    color: MyTheme.grayColor.withOpacity(0.2),
                    child: Icon(Icons.error,
                        size: 20.sp, color: MyTheme.grayColor2),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.itemsName ?? 'Not Available',
                      style: textTheme.titleMedium?.copyWith(
                        color: MyTheme.blackColor,
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.itemsDescription ?? 'No Description',
                      style: textTheme.bodySmall?.copyWith(
                        color: MyTheme.grayColor2,
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              discountedPrice > 0
                                  ? '$discountedPrice EGP'
                                  : '${item.itemsPrice ?? '0.0'} EGP',
                              style: textTheme.titleSmall?.copyWith(
                                color: MyTheme.greenColor,
                                fontSize: 12.sp,
                              ),
                            ),
                            if (discount > 0) ...[
                              SizedBox(width: 6.w),
                              Text(
                                '${item.itemsPrice ?? '0.0'} EGP',
                                style: textTheme.bodySmall?.copyWith(
                                  color: MyTheme.redColor,
                                  fontSize: 10.sp,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: item.itemsActive == "1"
                                ? MyTheme.greenColor.withOpacity(0.2)
                                : MyTheme.redColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            item.itemsActive == "1"
                                ? 'Available'
                                : 'Not Available',
                            style: textTheme.bodySmall?.copyWith(
                              color: item.itemsActive == "1"
                                  ? MyTheme.greenColor
                                  : MyTheme.redColor,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
