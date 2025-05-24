import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';
import 'ServicesAppBar.dart';
import 'ServicesCarousel.dart';
import 'ServicesFloatingButton.dart';
import 'ServicesList.dart';

class ServicesScreen extends StatelessWidget {
  static const String routeName = 'ServicesScreen';
  final String categoryId;
  final String categoryName;

  const ServicesScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final int parsedCategoryId = int.tryParse(categoryId) ?? 0;
    return BlocProvider(
      create: (context) =>
          HomeBloc()..add(FetchServicesEvent(parsedCategoryId)),
      child: Scaffold(
        appBar: ServicesAppBar(categoryName: categoryName),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[100]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Column(
            children: [
              ServicesCarousel(),
              ServicesList(),
            ],
          ),
        ),
        floatingActionButton:
            ServicesFloatingButton(categoryId: parsedCategoryId),
      ),
    );
  }
}
