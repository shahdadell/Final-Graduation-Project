import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'checkEmail_state.dart';

class CheckEmailViewModel extends Cubit<CheckEmailState> {
  CheckEmailViewModel({required this.repositoryContract})
      : super(CheckEmailInitialState());
  TextEditingController emailController = TextEditingController();

  bool? value = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepositoryContract repositoryContract;

  void CheckEmail(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
        emit(CheckEmailLoadingState(checkEmailMassage: "Loading..."));
        var response = await repositoryContract.checkemail(
          emailController.text,
        );
        if (response.status == 'failure') {
          emit(CheckEmailErrorState(checkEmailErrorMessage: response.message));
        } else {
          emit(
            CheckEmailSuccessState(checkEmailResponse: response),
          );
        }
      } catch (e) {
        emit(
          CheckEmailErrorState(
            checkEmailErrorMessage: e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
