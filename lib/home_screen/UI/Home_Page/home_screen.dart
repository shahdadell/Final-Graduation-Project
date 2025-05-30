import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/home_screen/UI/TopBarWidget/TopBarWidget.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import '../CategoriesGridWidget/CategoriesGridWidget.dart';
import '../DiscountListWidget/DiscountListWidget.dart';
import '../SearchFieldWidget/SearchFieldWidget.dart';
import '../SpecialOfferCarouselWidget/SpecialOfferCarouselWidget.dart';
import '../TopSellingListWidget/TopSellingListWidget.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchHomeDataEvent(null));
    context.read<HomeBloc>().add(FetchTopSellingEvent());
    context.read<HomeBloc>().add(FetchOffersEvent());
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (kDebugMode) {
        print("Timer: Refreshing home data");
      }
      context.read<HomeBloc>().add(FetchHomeDataEvent(null));
      context.read<HomeBloc>().add(FetchTopSellingEvent());
      context.read<HomeBloc>().add(FetchOffersEvent());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) async {
        String? errorMessage;
        bool isGuest = await AppLocalStorage.isGuest();

        if (state is HomeErrorState) {
          errorMessage = state.message;
        } else if (state is FetchOffersErrorState) {
          errorMessage = state.message;
        } else if (state is FetchTopSellingErrorState) {
          errorMessage = state.message;
        } else if (state is FetchCategoriesErrorState) {
          errorMessage = state.message;
        } else if (state is FetchDiscountItemsErrorState) {
          errorMessage = state.message;
        }

        if (errorMessage != null && !isGuest) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $errorMessage')),
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[100]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBarWidget(),
                  const SearchFieldWidget(isClickable: true),
                  SizedBox(height: 10.h),
                  const SpecialOfferCarouselWidget(),
                  SizedBox(height: 15.h),
                  const CategoriesGridWidget(),
                  SizedBox(height: 15.h),
                  const DiscountListWidget(),
                  SizedBox(height: 10.h),
                  const TopSellingListWidget(),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}