import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'ItemsAppBar.dart';
import 'ItemsGrid.dart';
import 'LockedContent.dart';

class ServiceItemsScreen extends StatelessWidget {
  static const String routeName = 'ServiceItemsScreen';
  final int serviceId;

  const ServiceItemsScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId == null) {
      return const Scaffold(
        appBar: ItemsAppBar(),
        body: LockedContent(),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()
            ..add(FetchServiceItemsEvent(serviceId: serviceId, userId: userId)),
        ),
      ],
      child: Scaffold(
        appBar: const ItemsAppBar(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[100]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const ItemsGrid(),
        ),
      ),
    );
  }
}
