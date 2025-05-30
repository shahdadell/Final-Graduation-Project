import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/OTP/OtpCubit/OtpCubit.dart';
import 'package:pinput/pinput.dart';

class OtpField extends StatefulWidget {
  final String email;
  final TextEditingController otpController;
  const OtpField({
    required this.otpController,
    required this.email,
    super.key,
  });

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {
    OtpCubit cubit = context.read<OtpCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Pinput(
        length: 5,
        controller: widget.otpController,
        defaultPinTheme: PinTheme(
          width: 35.w,
          height: 45.w,
          textStyle: GoogleFonts.dmSerifDisplay(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: MyTheme.blackColor,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: MyTheme.grayColor2,
              width: 1.5.w,
            ),
          ),
        ),
        focusedPinTheme: PinTheme(
          width: 35.w,
          height: 45.w,
          textStyle: GoogleFonts.dmSerifDisplay(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: MyTheme.blackColor,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: MyTheme.orangeColor,
              width: 1.5.w,
            ),
          ),
        ),
        submittedPinTheme: PinTheme(
          width: 35.w,
          height: 45.w,
          textStyle: GoogleFonts.dmSerifDisplay(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: MyTheme.blackColor,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: MyTheme.orangeColor,
              width: 1.5.w,
            ),
          ),
        ),
        onCompleted: (value) {
          cubit.verifyCode(
            context,
            widget.email,
            widget.otpController.text,
          );
        },
        showCursor: true,
      ),
    );
  }
}
