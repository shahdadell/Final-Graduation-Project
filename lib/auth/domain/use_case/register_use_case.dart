// import 'package:graduation_project/auth/data/model/response/Register/RegisterResponse.dart';
import 'package:graduation_project/auth/data/model/response/Register/registerresponse_new.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';

class RegisterUseCase {
  AuthRepositoryContract repositoryContract;
  RegisterUseCase({required this.repositoryContract});

  Future<RegisterresponseNew> invoke(
      String password, String email, String phone, String userName) {
    return repositoryContract.register(password, email, password, userName);
  }
}
