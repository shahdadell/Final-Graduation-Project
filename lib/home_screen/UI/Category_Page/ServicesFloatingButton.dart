import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';

class ServicesFloatingButton extends StatelessWidget {
  final int categoryId;

  const ServicesFloatingButton({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<HomeBloc>(context).add(FetchServicesEvent(categoryId));
      },
      backgroundColor: MyTheme.orangeColor,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Icon(Icons.refresh, size: 24.w, color: Colors.white),
    );
  }
}
