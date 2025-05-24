import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/Home/home_state.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/ui/category_page/Services_Screen.dart';

class CategoriesGridWidget extends StatelessWidget {
  const CategoriesGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is FetchLoadingHomeDataState) {
          return Container(
            height: 150.h,
            child: Center(
                child: CircularProgressIndicator(color: MyTheme.orangeColor)),
          );
        } else if (state is FetchSuccessHomeDataState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 0.9,
              ),
              itemCount: state.categories.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicesScreen(
                          categoryId:
                              state.categories[index].categoriesId.toString(),
                          categoryName:
                              state.categories[index].categoriesName ??
                                  'Unknown',
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.grey[50]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6.r,
                              spreadRadius: 1.r,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            state.categories[index].categoriesImage ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: Icon(Icons.broken_image,
                                    size: 25.w, color: Colors.grey[400]),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        state.categories[index].categoriesName ?? 'Unknown',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is HomeErrorState) {
          return SizedBox(
            height: 150.h,
            child: Center(
                child: Text("Error: ${state.message}",
                    style: TextStyle(fontSize: 14.sp))),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
