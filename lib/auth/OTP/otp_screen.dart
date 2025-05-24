import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Theme/dialog_utils.dart';
import 'package:graduation_project/Theme/dialogs.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/app_images/app_images.dart';
import 'package:graduation_project/auth/OTP/OtpCubit/OtpCubit.dart';
import 'package:graduation_project/auth/OTP/OtpCubit/OtpState.dart';
import 'package:graduation_project/auth/OTP/text_filed_otp_screem.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/data_source/auth_remote_data_source_impl.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/repository/auth_repository_impl.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';
import 'package:graduation_project/functions/navigation.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

class OtpScreen extends StatefulWidget {
  static const String routName = 'OtpScreen';
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final TextEditingController otpController;

  @override
  void initState() {
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(
        authRepositoryContract: injectAuthRepositoryContract(),
      ),
      child: BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpLoadingState) {
            showLoadingDialog(context);
          } else if (state is OtpErrorState) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            String errorMessage = state.errorMessage ?? "An error occurred";
            if (errorMessage.contains("Session expired")) {
              DialogUtils.showMessage(
                context,
                "Your session has expired. Please log in again.",
                posActionName: 'Ok',
                posAction: () {
                  AppLocalStorage.clearData();
                  pushAndRemoveUntil(context, const SignInScreen());
                },
              );
            } else if (errorMessage.contains("No internet connection")) {
              DialogUtils.showMessage(
                context,
                "No internet connection. Please check your network and try again.",
                posActionName: 'Ok',
              );
            } else {
              DialogUtils.showMessage(context, errorMessage,
                  posActionName: 'Ok');
            }
          } else if (state is OtpSuccessState) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            DialogUtils.showMessage(
              context,
              "Verification successful! Please log in.",
              posActionName: 'Ok',
              posAction: () {
                pushAndRemoveUntil(context, const SignInScreen());
              },
            );
          } else if (state is OtpResendSuccessState) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            DialogUtils.showMessage(
              context,
              "Code resent successfully! Check your email.",
              posActionName: 'Ok',
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
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
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(16.r)),
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
            child: Builder(
              builder: (context) {
                final cubit = BlocProvider.of<OtpCubit>(context);
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
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
                          "We've sent a code to ${widget.email}",
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
                        OtpField(
                          email: widget.email,
                          otpController: otpController,
                        ).animate().fadeIn(duration: 600.ms).slideY(
                              begin: 0.1,
                              end: 0.0,
                              duration: 600.ms,
                              curve: Curves.easeOut,
                            ),
                        SizedBox(height: 20.h),
                        BlocBuilder<OtpCubit, OtpState>(
                          builder: (context, state) {
                            return Row(
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
                                if (cubit.canResend)
                                  GestureDetector(
                                    onTap: () {
                                      cubit.resendCode(widget.email);
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
                                    "Resend in ${cubit.resendCountdown}s",
                                    style: GoogleFonts.dmSerifDisplay(
                                      color: MyTheme.grayColor2,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ).animate().fadeIn(duration: 600.ms).slideY(
                              begin: 0.1,
                              end: 0.0,
                              duration: 600.ms,
                              curve: Curves.easeOut,
                            ),
                        SizedBox(height: 30.h),
                        BlocBuilder<OtpCubit, OtpState>(
                          builder: (context, state) {
                            String code = otpController.text;
                            bool isEnabled = code.length == 5;
                            return _buildButton(
                              context,
                              text: "Verify",
                              color: isEnabled
                                  ? MyTheme.orangeColor
                                  : MyTheme.grayColor,
                              onPressed: isEnabled
                                  ? () {
                                      cubit.verifyCode(
                                          context, widget.email, code);
                                    }
                                  : null,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String text,
    required Color color,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 3,
        shadowColor: MyTheme.grayColor3.withOpacity(0.4),
      ),
      child: Text(
        text,
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
        );
  }
}

AuthRepositoryContract injectAuthRepositoryContract() {
  return AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSourceImpl(
      apiManager: ApiManager.getInstance(),
    ),
  );
}
