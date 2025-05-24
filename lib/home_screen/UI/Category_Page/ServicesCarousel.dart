import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';

class ServicesCarousel extends StatelessWidget {
  const ServicesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is FetchServicesSuccessState && state.services.isNotEmpty) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 150.h,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
                viewportFraction: 0.8,
              ),
              items: state.services.take(3).map((service) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8.r,
                            spreadRadius: 2.r,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            service.serviceImage != null &&
                                    service.serviceImage!.isNotEmpty
                                ? Image.network(
                                    service.serviceImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50.w,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.4),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10.h,
                              left: 10.w,
                              child: Text(
                                service.serviceName ?? 'No Name',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
