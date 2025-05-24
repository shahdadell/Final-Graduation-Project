import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'package:graduation_project/home_screen/data/model/offers_model_response/offers_model_response/offers_model_response.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'offers_screen.dart';

class SpecialOfferCarouselWidget extends StatefulWidget {
  const SpecialOfferCarouselWidget({super.key});

  @override
  State<SpecialOfferCarouselWidget> createState() =>
      _SpecialOfferCarouselWidgetState();
}

class _SpecialOfferCarouselWidgetState
    extends State<SpecialOfferCarouselWidget> {
  int currentIndex = 0;
  List<OffersModelResponse> lastOffers = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Text(
            "Special Offers",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: MyTheme.blackColor,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: const Offset(1, 1),
                  blurRadius: 3.r,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is FetchOffersSuccessState) {
                    lastOffers = state.offers;
                  }

                  if (state is FetchOffersLoadingState && lastOffers.isEmpty) {
                    return SizedBox(
                      height: 180.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: MyTheme.orangeColor,
                          strokeWidth: 4.w,
                        ),
                      ),
                    );
                  }

                  if (state is FetchOffersErrorState) {
                    return SizedBox(
                      height: 180.h,
                      child: Center(
                        child: Text(
                          "Error loading offers",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    );
                  }

                  final offersToDisplay = (state is FetchOffersSuccessState)
                      ? state.offers
                      : lastOffers;

                  if (offersToDisplay.isEmpty) {
                    return SizedBox(
                      height: 180.h,
                      child: Center(
                        child: Text(
                          "No offers available",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OffersScreen.routeName);
                    },
                    child: CarouselSlider.builder(
                      itemCount: offersToDisplay.length,
                      itemBuilder: (context, index, realIndex) {
                        final offer = offersToDisplay[index];
                        final displayTitle =
                            offer.title == null || offer.title!.isEmpty
                                ? 'No Title'
                                : offer.title!.length > 20
                                    ? '${offer.title!.substring(0, 20)}...'
                                    : offer.title!;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 4.r,
                                spreadRadius: 1.r,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  offer.image ?? '',
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: MyTheme.orangeColor,
                                          strokeWidth: 3.w,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 30.w,
                                        color: Colors.grey[400],
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.4),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12.h,
                                  left: 12.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayTitle,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black87,
                                              blurRadius: 2.r,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (offer.price != null)
                                        Text(
                                          "${offer.price} EGP",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 160.h,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        autoPlayInterval: const Duration(seconds: 4),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final offersToDisplay = (state is FetchOffersSuccessState)
                      ? state.offers
                      : lastOffers;
                  if (offersToDisplay.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: AnimatedSmoothIndicator(
                        activeIndex: currentIndex,
                        count: offersToDisplay.length > 5
                            ? 5
                            : offersToDisplay.length,
                        effect: WormEffect(
                          activeDotColor: MyTheme.orangeColor,
                          dotColor: Colors.grey[300]!,
                          dotWidth: 6.w,
                          dotHeight: 6.h,
                          spacing: 5.w,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
