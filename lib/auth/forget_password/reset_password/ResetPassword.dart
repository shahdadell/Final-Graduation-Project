import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/App_Images/app_images.dart';
import 'package:graduation_project/Theme/dialog_utils.dart';
import 'package:graduation_project/Theme/dialogs.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/forget_password/reset_password/cubit/reset_password_viewmodel.dart';
import 'package:graduation_project/auth/forget_password/reset_password/cubit/reset_state.dart';
import 'package:graduation_project/auth/forget_password/reset_password/text_filed_reset.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';

class ResetPassword extends StatefulWidget {
  static const String routName = 'resetPassword';
  final String email;

  const ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late ResetPasswordScreenViewmodel viewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel = ResetPasswordScreenViewmodel(
      repositoryContract: injectAuthRepositoryContract(),
    );
    viewmodel.setEmail(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordScreenViewmodel, ResetPasswordState>(
      bloc: viewmodel,
      listener: (context, state) {
        if (state is ResetPasswordLoadingState) {
          showLoadingDialog(context);
        } else if (state is ResetPasswordErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, state.errorMessage!,
              posActionName: 'Ok');
        } else if (state is ResetPasswordSuccessState) {
          DialogUtils.hideLoading(context);
          Navigator.of(context).pushReplacementNamed(SignInScreen.routName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "Reset Password",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Form(
          key: viewmodel.formKey,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    AppImages.sign,
                    width: 170,
                    height: 170,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Your Email",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  TextFiledResetPassword(
                    controller: viewmodel.emailController,
                    text: 'Email',
                    icon: Icons.email,
                    type: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    password: false,
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Enter Your New Password",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  TextFiledResetPassword(
                    controller:
                        viewmodel.passwordControllerOne, // حقل الباسورد الوحيد
                    text: 'New Password',
                    icon: Icons.lock,
                    type: TextInputType.visiblePassword,
                    action: TextInputAction.done, // غيرته لـ done لأنه آخر حقل
                    password: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      viewmodel.resetPassword(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(11),
                      backgroundColor: MyTheme.orangeColor,
                    ),
                    child: Text(
                      "Reset Password",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    viewmodel.close();
    super.dispose();
  }
}
