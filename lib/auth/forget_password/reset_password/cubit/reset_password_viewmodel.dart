import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/forget_password/reset_password/cubit/reset_state.dart';

class ResetPasswordScreenViewmodel extends Cubit<ResetPasswordState> {
  ResetPasswordScreenViewmodel({required this.repositoryContract})
      : super(ResetPasswordInitialState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordControllerOne =
      TextEditingController(); // حقل الباسورد الوحيد
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepositoryContract repositoryContract;

  void setEmail(String userEmail) {
    emailController.text = userEmail;
  }

  void resetPassword(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
        emit(
            ResetPasswordLoadingState(loadingMessage: "Resetting Password..."));

        var response = await repositoryContract.resetPassword(
          emailController.text,
          passwordControllerOne.text,
        );

        if (response.status == 'success') {
          emit(ResetPasswordSuccessState(response: response));
        } else {
          emit(ResetPasswordErrorState(
              errorMessage: "Failed to reset password"));
        }
      } catch (e) {
        emit(ResetPasswordErrorState(
            errorMessage: "An unexpected error occurred: $e"));
      }
    } else {
      emit(ResetPasswordErrorState(
          errorMessage: "Please provide a valid email and password"));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordControllerOne.dispose(); // حذف passwordControllerTwo
    return super.close();
  }
}
