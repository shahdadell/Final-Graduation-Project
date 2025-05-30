import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:graduation_project/Profile_screen/UI/Addresses/add_address_screen.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_state.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'edit_address_screen.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  _AddressesScreenState createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  bool isDialogShown = false; // تتبع إذا كان الـ Dialog ظهر
  Map<String, bool> isDeleteButtonEnabled =
      {}; // تتبع حالة زرار الحذف لكل عنوان

  @override
  Widget build(BuildContext context) {
    context.read<AddressBloc>().add(FetchAddressesEvent());
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
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
          "My Addresses",
          style: textTheme.displayLarge?.copyWith(
            fontSize: 20.sp,
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
        child: BlocConsumer<AddressBloc, AddressState>(
          listener: (context, state) {
            // نمنع تكرار الـ Dialog
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
            } else if (state is DeleteAddressSuccessState) {
              setState(() {
                isDialogShown = true;
              });
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                title: 'Success',
                desc: 'Address deleted successfully',
                btnOkText: 'OK',
                btnOkColor: MyTheme.orangeColor,
                btnOkOnPress: () {
                  setState(() {
                    isDialogShown = false;
                    // إعادة تفعيل زرار الحذف للعنوان
                    isDeleteButtonEnabled.clear(); // إعادة تعيين كل الأزرار
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
            } else if (state is DeleteAddressErrorState) {
              setState(() {
                isDialogShown = true;
              });
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: 'Error',
                desc: 'Error deleting address: ${state.message}',
                btnOkText: 'OK',
                btnOkColor: MyTheme.redColor,
                btnOkOnPress: () {
                  setState(() {
                    isDialogShown = false;
                    // إعادة تفعيل زرار الحذف للعنوان
                    isDeleteButtonEnabled.clear(); // إعادة تعيين كل الأزرار
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
            } else if (state is EditAddressSuccessState) {
              setState(() {
                isDialogShown = true;
              });
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                title: 'Success',
                desc: 'Address updated successfully',
                btnOkText: 'OK',
                btnOkColor: MyTheme.orangeColor,
                btnOkOnPress: () {
                  setState(() {
                    isDialogShown = false;
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
            } else if (state is EditAddressErrorState) {
              setState(() {
                isDialogShown = true;
              });
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: 'Error',
                desc: 'Error updating address: ${state.message}',
                btnOkText: 'OK',
                btnOkColor: MyTheme.redColor,
                btnOkOnPress: () {
                  setState(() {
                    isDialogShown = false;
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
          builder: (context, state) {
            if (state is FetchAddressesLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: MyTheme.orangeColor),
              );
            } else if (state is FetchAddressesSuccessState) {
              final addresses = state.viewAddresses.data ?? [];
              if (addresses.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/images/empty_addresses.json',
                        width: 150.w,
                        height: 150.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No Addresses Found',
                        style: textTheme.titleLarge?.copyWith(
                          color: MyTheme.grayColor2,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Add a new address to get started!',
                        style: textTheme.bodyMedium?.copyWith(
                          color: MyTheme.grayColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  final addressId = address.addressId ?? '';
                  // تهيئة حالة زرار الحذف للعنوان إذا لم تكن موجودة
                  isDeleteButtonEnabled.putIfAbsent(addressId, () => true);
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: BoxDecoration(
                      color: MyTheme.whiteColor,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: MyTheme.grayColor3.withOpacity(0.2),
                          blurRadius: 8.r,
                          spreadRadius: 1.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      leading: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: MyTheme.orangeColor.withOpacity(0.1),
                        child: Icon(
                          Icons.location_on,
                          color: MyTheme.orangeColor,
                          size: 20.w,
                        ),
                      ),
                      title: Text(
                        address.addressName ?? 'No Name',
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${address.addressStreet ?? ''}, ${address.addressCity ?? ''}\nPhone: ${address.addressPhone ?? ''}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: MyTheme.grayColor2,
                          fontSize: 12.sp,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: MyTheme.blueColor,
                              size: 20.w,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditAddressScreen(address: address),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: isDeleteButtonEnabled[addressId]!
                                  ? MyTheme.orangeColor
                                  : MyTheme.grayColor,
                              size: 20.w,
                            ),
                            onPressed: isDeleteButtonEnabled[addressId]!
                                ? () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.scale,
                                      title: 'Delete Address',
                                      desc:
                                          'Are you sure you want to delete this address?',
                                      btnCancelText: 'Cancel',
                                      btnOkText: 'Delete',
                                      btnCancelColor: MyTheme.grayColor,
                                      btnOkColor: MyTheme.redColor,
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        setState(() {
                                          isDeleteButtonEnabled[addressId] =
                                              false; // تعطيل زرار الحذف
                                        });
                                        context.read<AddressBloc>().add(
                                              DeleteAddressEvent(
                                                  addressId: addressId),
                                            );
                                      },
                                    ).show();
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: (100 * index).ms)
                      .slideX(begin: -0.1);
                },
              );
            } else if (state is FetchAddressesErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/images/favouriteEmpty.json',
                      width: 150.w,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Error: ${state.message}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: MyTheme.redColor,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAddressScreen(),
            ),
          );
        },
        backgroundColor: MyTheme.orangeColor,
        elevation: 3,
        child: Icon(
          Icons.add,
          color: MyTheme.whiteColor,
          size: 24.w,
        ),
      ).animate().scale(duration: 400.ms, curve: Curves.easeInOut),
    );
  }
}
