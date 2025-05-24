import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/sign_up_screen/cubit/register_state.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

class RegisterScreenViewmodel extends Cubit<RegisterState> {
  RegisterScreenViewmodel({required this.repositoryContract})
      : super(RegisterInitialState());

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? value = false;
  var formKey = GlobalKey<FormState>();
  AuthRepositoryContract repositoryContract;
  Future<void> SignUp([BuildContext? context]) async {
    if (formKey.currentState?.validate() == true) {
      try {
        emit(RegisterLoadingState(loadingMassage: "Loading..."));
        var response = await repositoryContract.register(
          userNameController.text,
          passwordController.text,
          emailController.text,
          phoneController.text,
        );
        if (response.status == 'failure') {
          emit(RegisterErrorState(errorMessage: response.message));
        } else {
          AppLocalStorage.cacheData(
              'user_name',
              userNameController
                  .text); // ده جزء التوكن لو الكود باظ تاني امسحيه من هنا او اعمليه كومنت هيرجع يشتغل
          AppLocalStorage.cacheData(
              'user_id',
              response
                  .userId); // ده جزء التوكن لو الكود باظ تاني امسحيه من هنا او اعمليه كومنت هيرجع يشتغل
          emit(RegisterSuccessState(response: response));
        }
      } catch (e) {
        emit(RegisterErrorState(
            errorMessage: e.toString().replaceAll('Exception: ', '')));
      }
    }
  }
}
