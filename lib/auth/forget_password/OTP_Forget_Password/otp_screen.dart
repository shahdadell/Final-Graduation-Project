// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/App_Images/app_images.dart';
import 'package:graduation_project/Theme/dialog_utils.dart';
import 'package:graduation_project/Theme/dialogs.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/forget_password/reset_password/ResetPassword.dart';

class OtpScreenForgetPassword extends StatefulWidget {
  static const String routName = 'otpScreenf';

  const OtpScreenForgetPassword({super.key});

  @override
  State<OtpScreenForgetPassword> createState() =>
      _OtpScreenForgetPasswordState();
}

class _OtpScreenForgetPasswordState extends State<OtpScreenForgetPassword> {
  ApiManager apiManager = ApiManager.getInstance();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();

  bool _isButtonEnabled = false;
  bool canResend = false;
  int resendCountdown = 60;

  @override
  void initState() {
    super.initState();
    otpController1.addListener(_checkOtpFields);
    otpController2.addListener(_checkOtpFields);
    otpController3.addListener(_checkOtpFields);
    otpController4.addListener(_checkOtpFields);
    otpController5.addListener(_checkOtpFields);
    print("Starting resend timer...");
    _startResendTimer();
  }

  void _checkOtpFields() {
    setState(() {
      _isButtonEnabled = otpController1.text.isNotEmpty &&
          otpController2.text.isNotEmpty &&
          otpController3.text.isNotEmpty &&
          otpController4.text.isNotEmpty &&
          otpController5.text.isNotEmpty;
    });
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (resendCountdown > 0) {
            print("Countdown: $resendCountdown");
            resendCountdown--;
            _startResendTimer();
          } else {
            print("Can resend now!");
            canResend = true;
          }
        });
      }
    });
  }

  Future<void> resendCode(String email) async {
    print("Resend Code tapped for email: $email");
    setState(() {
      canResend = false;
      resendCountdown = 60;
      print("Resetting timer...");
      _startResendTimer();
    });

    try {
      showLoadingDialog(context);
      print("Calling API to resend code...");
      var response = await apiManager.resendCode(email);
      print("Resend Response: ${response.toString()}");
      DialogUtils.hideLoading(context);

      if (response.status == "success") {
        print("Resend successful!");
        DialogUtils.showMessage(
          context,
          "Code resent successfully! Check your email.",
          title: "Success",
          posActionName: 'Ok',
        );
      } else {
        print("Resend failed: ${response.status}");
        DialogUtils.showMessage(
          context,
          response.status ?? "Failed to resend code.",
          title: "Error",
          posActionName: 'Ok',
        );
      }
    } catch (e) {
      print("Error during resend: $e");
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
        context,
        "An error occurred: ${e.toString()}",
        title: "Error",
        posActionName: 'Ok',
      );
    }
  }

  @override
  void dispose() {
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    otpController5.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: MyTheme.whiteColor,
              size: 24.w,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: MyTheme.orangeColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
        ),
        title: Text(
          "Verification Code",
          style: GoogleFonts.dmSerifDisplay(
            color: MyTheme.whiteColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(
              begin: 0.1,
              end: 0.0,
              duration: 400.ms,
              curve: Curves.easeOut,
            ),
      ),
      body: Container(
        color: MyTheme.whiteColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 140.w,
                  height: 140.h,
                ).animate().fadeIn(duration: 500.ms).scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.0, 1.0),
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    ),
                SizedBox(height: 15.h),
                Text(
                  "Enter the 5-digit code sent to your email",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSerifDisplay(
                    color: MyTheme.grayColor2,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(
                      begin: 0.1,
                      end: 0.0,
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    ),
                SizedBox(height: 5.h),
                Text(
                  "We've sent a code to $email",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSerifDisplay(
                    color: MyTheme.grayColor2,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(
                      begin: 0.1,
                      end: 0.0,
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    ),
                SizedBox(height: 20.h),
                Form(
                  key: formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOtpField(otpController1, focusNode1, 0),
                      _buildOtpField(otpController2, focusNode2, 1),
                      _buildOtpField(otpController3, focusNode3, 2),
                      _buildOtpField(otpController4, focusNode4, 3),
                      _buildOtpField(otpController5, focusNode5, 4),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(
                      begin: 0.1,
                      end: 0.0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive a code? ",
                      style: GoogleFonts.dmSerifDisplay(
                        color: MyTheme.grayColor2,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (canResend)
                      GestureDetector(
                        onTap: () {
                          print("Resend Code tapped!");
                          resendCode(email);
                        },
                        child: Text(
                          "Resend Code",
                          style: GoogleFonts.dmSerifDisplay(
                            color: MyTheme.orangeColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Text(
                        "Resend in ${resendCountdown}s",
                        style: GoogleFonts.dmSerifDisplay(
                          color: MyTheme.grayColor2,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ).animate().fadeIn(duration: 600.ms).slideY(
                      begin: 0.1,
                      end: 0.0,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () async {
                          print("OTP Verify Button Pressed");

                          if (formKey.currentState!.validate()) {
                            String otpCode =
                                "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}${otpController5.text}";

                            print("Entered OTP: $otpCode");

                            var response = await apiManager
                                .verifyCodeForgetPassword(email, otpCode);

                            print(
                                "API Response: ${response.status}, Message: ${response.message}");

                            if (response.status == "success") {
                              print(
                                  "Verification Successful! Navigating to Reset Password...");
                              Navigator.of(context).pushReplacementNamed(
                                ResetPassword.routName,
                                arguments: email,
                              );
                            } else {
                              print("Verification Failed: ${response.message}");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response.message ??
                                      "Verification Failed"),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled
                        ? MyTheme.orangeColor
                        : MyTheme.grayColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 3,
                    shadowColor: MyTheme.grayColor3.withOpacity(0.4),
                  ),
                  child: Text(
                    "Verify",
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 14.sp,
                      color: MyTheme.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(1.0, 1.0),
                      end: const Offset(1.05, 1.05),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    )
                    .then()
                    .scale(
                      begin: const Offset(1.05, 1.05),
                      end: const Offset(1.0, 1.0),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(
      TextEditingController controller, FocusNode focusNode, int index) {
    return Container(
      width: 35.w,
      height: 45.h,
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
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: GoogleFonts.dmSerifDisplay(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: MyTheme.blackColor,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: MyTheme.grayColor2, width: 1.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: MyTheme.grayColor2, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: MyTheme.orangeColor, width: 1.5.w),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 4) {
            focusNode.unfocus();
            if (index == 0) focusNode2.requestFocus();
            if (index == 1) focusNode3.requestFocus();
            if (index == 2) focusNode4.requestFocus();
            if (index == 3) focusNode5.requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNode.unfocus();
            if (index == 1) focusNode1.requestFocus();
            if (index == 2) focusNode2.requestFocus();
            if (index == 3) focusNode3.requestFocus();
            if (index == 4) focusNode4.requestFocus();
          }
        },
      ),
    );
  }
}
