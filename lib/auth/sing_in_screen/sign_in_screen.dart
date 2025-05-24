import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/App_Images/app_images.dart';
import 'package:graduation_project/Notification_Page/notification_manager.dart';
import 'package:graduation_project/Profile_screen/bloc/Profile/profile_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Profile/profile_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Profile/profile_state.dart';
import 'package:graduation_project/Profile_screen/data/repo/profile_repo.dart';
import 'package:graduation_project/Theme/dialog_utils.dart';
import 'package:graduation_project/Theme/dialogs.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/Widgets/nav_bar_widget.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/data_source/auth_remote_data_source_impl.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/repository/auth_repository_impl.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/forget_password/check_email/forget_password_bottom_sheet.dart';
import 'package:graduation_project/auth/sing_in_screen/cubit/login_screen_viewmodel.dart';
import 'package:graduation_project/auth/sing_in_screen/cubit/login_state.dart';
import 'package:graduation_project/auth/sing_in_screen/text_filed_login.dart';
import 'package:graduation_project/functions/navigation.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import '../../main_screen/main_screen.dart';

class SignInScreen extends StatefulWidget {
  static const String routName = 'SignInScreen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  LoginScreenViewmodel viewmodel = LoginScreenViewmodel(
    repositoryContract: injectAuthRepositoryContract(),
  );

  @override
  void dispose() {
    viewmodel.emailController.dispose();
    viewmodel.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginScreenViewmodel, LoginState>(
      bloc: viewmodel,
      listener: (context, state) async {
        if (state is LoginLoadingState) {
          showLoadingDialog(context);
        } else if (state is LoginErrorState) {
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
          } else if (errorMessage.contains("Invalid response format")) {
            DialogUtils.showMessage(
              context,
              "Server error: Invalid response format. Please try again later.",
              posActionName: 'Ok',
            );
          } else {
            DialogUtils.showMessage(context, errorMessage, posActionName: 'Ok');
          }
        } else if (state is LoginSuccessState) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          final int? userId = state.response.userId; // userId دلوقتي int
          if (userId != null) {
            await AppLocalStorage.cacheData('user_id', userId); // بيتخزن كـ int
            await AppLocalStorage.cacheData(
                'token', state.response.accessToken);
            await AppLocalStorage.cacheData(
                'refresh_token', state.response.refreshToken);
            final tokenTimestamp = DateTime.now().millisecondsSinceEpoch;
            await AppLocalStorage.cacheData('token_timestamp', tokenTimestamp);
            // أضفنا تخزين token_expiry (التوكن صالح لمدة ساعة مثلاً)
            final tokenExpiry =
                tokenTimestamp + (3600 * 1000); // ساعة = 3600 ثانية
            await AppLocalStorage.cacheData('token_expiry', tokenExpiry);

            final profileBloc = ProfileBloc(ProfileRepo());
            profileBloc.add(FetchProfileEvent(
                userId.toString())); // userId بيترسل كـ String للـ Profile

            await for (final profileState in profileBloc.stream) {
              if (profileState is ProfileLoaded) {
                final username = profileState.profile.data?.usersName;
                await AppLocalStorage.cacheData(
                    AppLocalStorage.userNameKey, username);
                break;
              } else if (profileState is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Failed to load profile: ${profileState.message}'),
                  ),
                );
                break;
              }
            }

            await NotificationManager.subscribeToTopics();
            pushAndRemoveUntil(context, const NavBarWidget());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User ID not found')),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              pushWithReplacement(context, const MainScreen());
            },
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Icon(
                Icons.arrow_back_ios,
                color: MyTheme.blackColor,
                size: 24.w,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "Sign in",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 18.sp),
          ),
        ),
        body: Form(
          key: viewmodel.formKey,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    AppImages.sign,
                    width: 140.w,
                    height: 140.h,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "Email Address",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14.sp),
                  ),
                  SizedBox(height: 4.h),
                  TextFiledLogin(
                    text: 'Email Address ',
                    type: TextInputType.emailAddress,
                    action: TextInputAction.done,
                    icon: Icons.email,
                    controller: viewmodel.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "E-mail is required";
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "Password",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14.sp),
                  ),
                  SizedBox(height: 4.h),
                  TextFiledLogin(
                    controller: viewmodel.passwordController,
                    text: 'Password',
                    icon: Icons.lock,
                    type: TextInputType.visiblePassword,
                    action: TextInputAction.done,
                    password: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showForgetPasswordBottomSheet();
                        },
                        child: Text(
                          "Forget Password?",
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  ElevatedButton(
                    onPressed: () {
                      viewmodel.SignIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      backgroundColor: MyTheme.orangeColor,
                      minimumSize: Size(double.infinity, 35.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Sign in",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     viewmodel.logout(context);
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.symmetric(vertical: 6.h),
                  //     backgroundColor: Colors.red,
                  //     minimumSize: Size(double.infinity, 35.h),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8.r),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     "Logout (Test)",
                  //     textAlign: TextAlign.center,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .displaySmall!
                  //         .copyWith(fontSize: 13.sp),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showForgetPasswordBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ForgetPasswordBottomSheet(),
    );
  }
}

AuthRepositoryContract injectAuthRepositoryContract() {
  return AuthRepositoryImpl(
      remoteDataSource:
          AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance()));
}
