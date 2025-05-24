import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/UI/Items_Page/Items_screen.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'ServiceDialog.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is FetchServicesLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: MyTheme.orangeColor),
          );
        } else if (state is FetchServicesSuccessState) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: ListView.builder(
                itemCount: state.services.length,
                itemBuilder: (context, index) {
                  final service = state.services[index];
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 500 + (index * 100)),
                    builder: (context, opacity, child) {
                      return Opacity(
                        opacity: opacity,
                        child: child,
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ServiceItemsScreen.routeName,
                          arguments: {
                            'serviceId': int.tryParse(service.serviceId ?? '0') ?? 0,
                            'userId': 10,
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: service.serviceImage != null &&
                                          service.serviceImage!.isNotEmpty
                                      ? Image.network(
                                          service.serviceImage!,
                                          width: 90.w,
                                          height: 80.h,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                            width: 90.w,
                                            height: 80.h,
                                            color: Colors.grey[200],
                                            child: Icon(
                                              Icons.image_not_supported,
                                              size: 40.w,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        )
                                      : (service.categoriesImage != null &&
                                              service.categoriesImage!
                                                  .isNotEmpty
                                          ? Image.network(
                                              service.categoriesImage!,
                                              width: 90.w,
                                              height: 80.h,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                width: 90.w,
                                                height: 80.h,
                                                color: Colors.grey[200],
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 40.w,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 90.w,
                                              height: 80.h,
                                              color: Colors.grey[200],
                                              child: Icon(
                                                Icons.image_not_supported,
                                                size: 40.w,
                                                color: Colors.grey[400],
                                              ),
                                            )),
                                ),
                                SizedBox(width: 15.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.serviceName ?? 'No Name',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (service.categoriesName != null)
                                        Text(
                                          service.categoriesName!,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey[700],
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      SizedBox(height: 6.h),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.amber, size: 18.w),
                                          SizedBox(width: 4.w),
                                          Text(
                                            service.serviceRating ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.h),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.red, size: 18.w),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Text(
                                              service.serviceLocation ??
                                                  'Unknown location',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey[600],
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    MyTheme.orangeColor,
                                    Colors.transparent
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Center(
                              child: Wrap(
                                spacing: 10.w,
                                runSpacing: 10.h,
                                children: [
                                  if (service.servicePhone != null)
                                    _buildChip(
                                      label: "Call",
                                      icon: Icons.phone,
                                      color: Colors.green[800]!,
                                      onTap: () => showServiceDialog(
                                        context,
                                        "Phone Number",
                                        service.servicePhone ??
                                            "No Phone Number",
                                      ),
                                    ),
                                  if (service.serviceWebsite != null)
                                    _buildChip(
                                      label: "Website",
                                      icon: Icons.web,
                                      color: Colors.blue[800]!,
                                      onTap: () => showServiceDialog(
                                        context,
                                        "Website",
                                        service.serviceWebsite ??
                                            "No Website Available",
                                      ),
                                    ),
                                  _buildChip(
                                    label: "Details",
                                    icon: Icons.info,
                                    color: MyTheme.orangeColor,
                                    onTap: () => showServiceDialog(
                                      context,
                                      "More Details",
                                      '''
                              📌 Name: ${service.serviceName}
                              📌 Category: ${service.categoriesName}
                              📝 Description: ${service.serviceDescription}
                              📍 Location: ${service.serviceLocation}
                              ⭐ Rating: ${service.serviceRating}
                              ''',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is FetchServicesErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60.w, color: Colors.redAccent),
                SizedBox(height: 20.h),
                Text(
                  "Oops! Something Went Wrong",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Error: ${state.message}",
                  style: TextStyle(fontSize: 16.sp, color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildChip({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.w, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}