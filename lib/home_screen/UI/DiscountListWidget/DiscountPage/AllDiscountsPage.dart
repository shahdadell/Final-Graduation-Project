import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';

import 'discount_app_bar.dart';
import 'discount_list.dart';

class AllDiscountsPage extends StatelessWidget {
  const AllDiscountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchHomeDataEvent(null));
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: buildAppBar(context),
      body: const DiscountList(),
    );
  }
}
