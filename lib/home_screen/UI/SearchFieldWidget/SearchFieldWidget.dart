import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/UI/SearchFieldWidget/SearchScreen.dart';

class SearchFieldWidget extends StatefulWidget {
  final bool isClickable;
  final void Function(String query)? onSearch;

  const SearchFieldWidget({
    super.key,
    this.isClickable = false,
    this.onSearch,
  });

  @override
  _SearchFieldWidgetState createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: MyTheme.grayColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: MyTheme.grayColor, width: 1.w),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: MyTheme.grayColor2, size: 22.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: _controller,
              readOnly: widget.isClickable,
              onTap: () {
                if (widget.isClickable) {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                }
              },
              onChanged: (value) {
                widget.onSearch
                    ?.call(value); // بيبعت النص مباشرة لدالة onSearch
                setState(
                    () {}); // عشان يعمل Refresh للـ UI ويظهر/يخفي الـ Clear Button
              },
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: MyTheme.blackColor,
                    fontSize: 16.sp,
                  ),
              decoration: InputDecoration(
                hintText: "What are you looking for?",
                hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: MyTheme.grayColor2,
                      fontSize: 13.sp,
                    ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h), // أو bottom فقط حسب الشكل اللي يريحك
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear,
                            color: MyTheme.grayColor2, size: 20.sp),
                        onPressed: () {
                          _controller.clear();
                          widget.onSearch?.call('');
                          setState(() {});
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
