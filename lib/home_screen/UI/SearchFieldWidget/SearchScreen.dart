import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/UI/SearchFieldWidget/SearchFieldWidget.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_event.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'package:graduation_project/home_screen/data/model/search_model_response/SearchModelResponse.dart'
    as searchModel;
import 'package:graduation_project/home_screen/UI/SearchFieldWidget/SearchResultCard.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'SearchScreen';
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? _debounce;
  String _lastQuery = '';
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<HomeBloc>();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _homeBloc.add(ClearSearchEvent());
    super.dispose();
  }

  void search(String query) {
    _lastQuery = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      print('Search Query: $query');
      if (query.trim().isEmpty) {
        _homeBloc.add(ClearSearchEvent());
      } else {
        _homeBloc.add(FetchSearchEvent(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: MyTheme.whiteColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: MyTheme.whiteColor,
              size: 24.w,
            ),
          ),
        ),
        title: Text(
          "Search",
          style: MyTheme.lightTheme.textTheme.displayLarge?.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: MyTheme.grayColor3,
                blurRadius: 3.r,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.orangeColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.r),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            child: SearchFieldWidget(
              isClickable: false,
              onSearch: search,
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                print('Current State: $state');
                if (state is FetchSearchLoadingState) {
                  return Center(
                    child:
                        CircularProgressIndicator(color: MyTheme.orangeColor),
                  );
                } else if (state is FetchSearchSuccessState) {
                  if (state.services.isEmpty && state.items.isEmpty) {
                    return Center(
                      child: Text(
                        "No results found. Try another keyword!",
                        style: textTheme.titleMedium?.copyWith(
                          color: MyTheme.grayColor2,
                        ),
                      ),
                    );
                  }
                  final allResults = [...state.services, ...state.items];
                  return RefreshIndicator(
                    onRefresh: () async {
                      if (_lastQuery.isNotEmpty) {
                        _homeBloc.add(FetchSearchEvent(_lastQuery));
                      }
                    },
                    color: MyTheme.orangeColor,
                    child: Container(
                      color: MyTheme.whiteColor,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: allResults.length,
                        itemBuilder: (context, index) {
                          final result = allResults[index];
                          if (result is searchModel.Data) {
                            return SearchResultCard(service: result);
                          } else if (result is searchModel.ItemData) {
                            return ItemResultCard(item: result);
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ),
                  );
                } else if (state is FetchSearchErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Error: ${state.message}",
                          style: textTheme.titleMedium?.copyWith(
                            color: MyTheme.grayColor2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  );
                } else if (state is HomeInitialState) {
                  return Center(
                    child: Text(
                      "Find Something To Start 👀",
                      style: textTheme.titleMedium?.copyWith(
                        color: MyTheme.grayColor2,
                      ),
                    ),
                  );
                }
                return Center(
                  child: Text(
                    "Find Something To Start 👀",
                    style: textTheme.titleMedium?.copyWith(
                      color: MyTheme.grayColor2,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
