import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Main_Screen/main_screen.dart';
import 'package:graduation_project/Theme/dialog_utils.dart';
import 'package:graduation_project/Theme/dialogs.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/data_source/auth_remote_data_source_impl.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/repository/auth_repository_impl.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';
import 'package:graduation_project/auth/sing_in_screen/text_filed_login.dart';
import '../OTP_Forget_Password/otp_screen.dart';
import 'cubit/CheckEmail_ViewModel.dart';
import 'cubit/checkEmail_state.dart';

class ForgetPassword extends StatefulWidget {
  static const String routName = 'ForgetPassword';

  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  CheckEmailViewModel viewmodel = CheckEmailViewModel(
    repositoryContract: injectAuthRepositoryContract(),
  );

  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckEmailViewModel, CheckEmailState>(
      bloc: viewmodel,
      listener: (context, state) {
        if (state is CheckEmailLoadingState) {
          showLoadingDialog(context);
        } else if (state is CheckEmailErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.checkEmailErrorMessage!,
              posActionName: 'Ok');
        } else if (state is CheckEmailSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context, state.checkEmailResponse.message ?? '',
              posActionName: 'Ok', posAction: () {
            Navigator.of(context).pushReplacementNamed(
              OtpScreenForgetPassword.routName,
              arguments: viewmodel.emailController.text,
            );
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(SignInScreen.routName);
            },
            child: Padding(
              padding: EdgeInsets.all(10.w), // تقليل الـ padding
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
            "Check Email",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 18.sp), // تقليل حجم العنوان
          ),
        ),
        body: Form(
          key: viewmodel.formKey,
          child: Padding(
            padding: EdgeInsets.all(20.w), // تقليل الـ padding الكلي
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 15.h), // تقليل المسافة العلوية
                  Text(
                    "Email Address",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14.sp), // تقليل حجم النص
                  ),
                  SizedBox(height: 4.h), // تقليل المسافة
                  TextFiledLogin(
                    text: 'Email Address',
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
                  SizedBox(height: 15.h), // تقليل المسافة
                  ElevatedButton(
                    onPressed: () {
                      viewmodel.CheckEmail(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 6.h), // تقليل الـ padding
                      backgroundColor: MyTheme.orangeColor,
                      minimumSize:
                          Size(double.infinity, 35.h), // تقليل ارتفاع الزر
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r), // زوايا أنيقة
                      ),
                    ),
                    child: Text(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 13.sp), // تقليل حجم النص
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

AuthRepositoryContract injectAuthRepositoryContract() {
  return AuthRepositoryImpl(
      remoteDataSource:
          AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance()));
}
