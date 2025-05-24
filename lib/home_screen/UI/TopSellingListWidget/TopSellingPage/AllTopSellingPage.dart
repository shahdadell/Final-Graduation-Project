import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';
import 'topselling_app_bar.dart';
import 'topsellingt_list.dart';

class AllTopSellingPage extends StatefulWidget {
  const AllTopSellingPage({super.key});

  @override
  _AllTopSellingPageState createState() => _AllTopSellingPageState();
}

class _AllTopSellingPageState extends State<AllTopSellingPage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchTopSellingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: buildAppBar(context),
      body: const TopSellingList(),
    );
  }
}
