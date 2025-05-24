// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/sing_in_screen/cubit/login_state.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

class LoginScreenViewmodel extends Cubit<LoginState> {
  LoginScreenViewmodel({required this.repositoryContract})
      : super(LoginInitialState());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? value = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepositoryContract repositoryContract;

  void SignIn(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
        emit(LoginLoadingState(loadingMassage: "Loading..."));
        var response = await repositoryContract.login(
            emailController.text, passwordController.text);
        if (response.status == 'failure' ||
            response.accessToken == null ||
            response.accessToken!.isEmpty) {
          emit(LoginErrorState(
              errorMessage: response.message ?? "Invalid email or password"));
        } else {
          await AppLocalStorage.cacheData('token', response.accessToken);
          await AppLocalStorage.cacheData(
              'refresh_token', response.refreshToken);
          await AppLocalStorage.cacheData('user_name', emailController.text);
          await AppLocalStorage.cacheData('user_id', response.userId);
          emit(LoginSuccessState(response: response));
        }
      } catch (e) {
        emit(LoginErrorState(errorMessage: e.toString()));
      }
    }
  }

  void logout(BuildContext context) async {
    try {
      emit(LoginLoadingState(loadingMassage: "Logging out..."));
      await AppLocalStorage.logout(context);
      emit(LoginInitialState());
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
