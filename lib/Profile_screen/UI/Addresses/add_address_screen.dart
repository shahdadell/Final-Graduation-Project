import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:graduation_project/Maps/map_picker_screen.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_state.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'addresses_screen.dart';
import 'package:flutter/services.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isDialogShown = false;
  bool isButtonEnabled = true;
  String latitude = '';
  String longitude = '';
  final formKey = GlobalKey<FormState>();
  final addressTitleController = TextEditingController();
  final addressPhoneController = TextEditingController();
  final addressDetailsController = TextEditingController();
  final addressCityController = TextEditingController();

  @override
  void dispose() {
    addressTitleController.dispose();
    addressPhoneController.dispose();
    addressDetailsController.dispose();
    addressCityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (isDialogShown) return;

        if (state is AddAddressSuccessState) {
          setState(() {
            isDialogShown = true;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: 'Success',
            desc: 'Address added successfully',
            btnOkText: 'OK',
            btnOkColor: MyTheme.orangeColor,
            btnOkOnPress: () {
              setState(() {
                isDialogShown = false;
              });
              // بدل ما نروح للـ AddressesScreen، هنرجع للـ CartScreen مع قيمة true
              Navigator.pop(context, true);
            },
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            titleTextStyle: textTheme.displayMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: MyTheme.blackColor,
            ),
            descTextStyle: textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: MyTheme.grayColor2,
            ),
          ).show();
        } else if (state is AddAddressErrorState) {
          setState(() {
            isDialogShown = true;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            title: 'Error',
            desc: 'Error adding address: ${state.message}',
            btnOkText: 'OK',
            btnOkColor: MyTheme.redColor,
            btnOkOnPress: () {
              setState(() {
                isDialogShown = false;
                isButtonEnabled = true;
              });
            },
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            titleTextStyle: textTheme.displayMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: MyTheme.blackColor,
            ),
            descTextStyle: textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: MyTheme.grayColor2,
            ),
          ).show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              // لما يضغط على زرار الرجوع، نرجع مع قيمة false
              Navigator.pop(context, false);
            },
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: MyTheme.whiteColor,
                size: 20.w,
              ),
            ),
          ).animate().scale(duration: 200.ms, curve: Curves.easeInOut),
          title: Text(
            "Add Address",
            style: textTheme.displayLarge?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: MyTheme.whiteColor,
            ),
          ).animate().fadeIn(duration: 400.ms).slideY(
            begin: 0.1,
            end: 0.0,
            duration: 400.ms,
            curve: Curves.easeOut,
          ),
          centerTitle: true,
          backgroundColor: MyTheme.orangeColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
        ),
        body: Container(
          color: MyTheme.whiteColor,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: BorderSide(
                      color: MyTheme.grayColor.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                  color: MyTheme.whiteColor,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: addressTitleController,
                            style: textTheme.bodyMedium?.copyWith(
                              color: MyTheme.blackColor,
                              fontSize: 15.sp,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Address Title',
                              labelStyle: textTheme.bodySmall?.copyWith(
                                color: MyTheme.blackColor,
                                fontSize: 13.sp,
                              ),
                              hintText: 'e.g., Home, Work',
                              hintStyle: textTheme.bodySmall?.copyWith(
                                color: MyTheme.grayColor2.withOpacity(0.6),
                                fontSize: 13.sp,
                              ),
                              suffixIcon: Icon(
                                Icons.label,
                                color: MyTheme.orangeColor,
                                size: 20.w,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.orangeColor,
                                  width: 1.5,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 14.h,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address title';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          TextFormField(
                            controller: addressPhoneController,
                            style: textTheme.bodyMedium?.copyWith(
                              color: MyTheme.blackColor,
                              fontSize: 15.sp,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: textTheme.bodySmall?.copyWith(
                                color: MyTheme.blackColor,
                                fontSize: 13.sp,
                              ),
                              hintText: 'e.g., 01234567890',
                              hintStyle: textTheme.bodySmall?.copyWith(
                                color: MyTheme.grayColor2.withOpacity(0.6),
                                fontSize: 13.sp,
                              ),
                              suffixIcon: Icon(
                                Icons.phone,
                                color: MyTheme.orangeColor,
                                size: 20.w,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.orangeColor,
                                  width: 1.5,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 14.h,
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                                return 'Phone number must be exactly 11 digits';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          TextFormField(
                            controller: addressCityController,
                            style: textTheme.bodyMedium?.copyWith(
                              color: MyTheme.blackColor,
                              fontSize: 15.sp,
                            ),
                            decoration: InputDecoration(
                              labelText: 'City',
                              labelStyle: textTheme.bodySmall?.copyWith(
                                color: MyTheme.blackColor,
                                fontSize: 13.sp,
                              ),
                              hintText: 'e.g., Fayoum',
                              hintStyle: textTheme.bodySmall?.copyWith(
                                color: MyTheme.grayColor2.withOpacity(0.6),
                                fontSize: 13.sp,
                              ),
                              suffixIcon: Icon(
                                Icons.location_city,
                                color: MyTheme.orangeColor,
                                size: 20.w,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.orangeColor,
                                  width: 1.5,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 14.h,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter city';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          TextFormField(
                            controller: addressDetailsController,
                            style: textTheme.bodyMedium?.copyWith(
                              color: MyTheme.blackColor,
                              fontSize: 15.sp,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Address Details',
                              labelStyle: textTheme.bodySmall?.copyWith(
                                color: MyTheme.blackColor,
                                fontSize: 13.sp,
                              ),
                              hintText: 'e.g., Street name, Building number',
                              hintStyle: textTheme.bodySmall?.copyWith(
                                color: MyTheme.grayColor2.withOpacity(0.6),
                                fontSize: 13.sp,
                              ),
                              suffixIcon: Icon(
                                Icons.location_on,
                                color: MyTheme.orangeColor,
                                size: 20.w,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.grayColor3.withOpacity(0.3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: MyTheme.orangeColor,
                                  width: 1.5,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 14.h,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address details';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          if (latitude.isNotEmpty && longitude.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    color: MyTheme.orangeColor,
                                    size: 20.w,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      'Selected Location: Lat: $latitude, Long: $longitude',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: MyTheme.blackColor,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 600.ms).scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1.0, 1.0),
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MapPickerScreen()),
                  );
                  if (result != null) {
                    setState(() {
                      latitude = result['latitude'];
                      longitude = result['longitude'];
                      addressCityController.text = result['city'] ?? '';
                      addressDetailsController.text = result['street'] ?? '';
                    });
                  }
                },
                icon: Icon(
                  Icons.map,
                  color: MyTheme.whiteColor,
                  size: 18.w,
                ),
                label: Text(
                  'Select Location',
                  style: textTheme.displayMedium?.copyWith(
                    color: MyTheme.whiteColor,
                    fontSize: 13.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.orangeColor,
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 3,
                  shadowColor: MyTheme.grayColor3.withOpacity(0.4),
                  minimumSize: Size(double.infinity, 40.h),
                ),
              )
                  .animate()
                  .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.03, 1.03),
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
              )
                  .then()
                  .scale(
                begin: const Offset(1.03, 1.03),
                end: const Offset(1.0, 1.0),
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
              ),
              SizedBox(height: 8.h),
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                  if (formKey.currentState!.validate()) {
                    if (latitude.isEmpty || longitude.isEmpty) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.scale,
                        title: 'Warning',
                        desc: 'Please select a location',
                        btnOkText: 'OK',
                        btnOkColor: MyTheme.redColor,
                        btnOkOnPress: () {},
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        titleTextStyle: textTheme.displayMedium?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.blackColor,
                        ),
                        descTextStyle: textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          color: MyTheme.grayColor2,
                        ),
                      ).show();
                      return;
                    }
                    setState(() {
                      isButtonEnabled = false;
                    });
                    context.read<AddressBloc>().add(
                      AddAddressEvent(
                        addressName: addressTitleController.text,
                        addressPhone: addressPhoneController.text,
                        addressCity: addressCityController.text,
                        addressStreet: addressDetailsController.text,
                        addressLat: latitude,
                        addressLong: longitude,
                      ),
                    );
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isButtonEnabled ? MyTheme.orangeColor : MyTheme.grayColor,
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 3,
                  shadowColor: MyTheme.grayColor3.withOpacity(0.4),
                  minimumSize: Size(double.infinity, 40.h),
                ),
                child: Text(
                  'Add Address',
                  style: textTheme.displayMedium?.copyWith(
                    color: MyTheme.whiteColor,
                    fontSize: 13.sp,
                  ),
                ),
              )
                  .animate()
                  .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.03, 1.03),
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
              )
                  .then()
                  .scale(
                begin: const Offset(1.03, 1.03),
                end: const Offset(1.0, 1.0),
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
              ),
              SizedBox(height: 8.h),
              ElevatedButton(
                onPressed: () {
                  // لما يضغط Cancel، نرجع مع قيمة false
                  Navigator.pop(context, false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.grayColor,
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 3,
                  shadowColor: MyTheme.grayColor3.withOpacity(0.4),
                  minimumSize: Size(double.infinity, 40.h),
                ),
                child: Text(
                  'Cancel',
                  style: textTheme.displayMedium?.copyWith(
                    color: MyTheme.whiteColor,
                    fontSize: 13.sp,
                  ),
                ),
              )
                  .animate()
                  .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.03, 1.03),
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
              )
                  .then()
                  .scale(
                begin: const Offset(1.03, 1.03),
                end: const Offset(1.0, 1.0),
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}