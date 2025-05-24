import 'package:graduation_project/auth/data/model/response/OTP/CheckEmailResponse.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';

class CheckEmailUseCase {
  AuthRepositoryContract repositoryContract;
  CheckEmailUseCase({required this.repositoryContract});

  Future<CheckEmailResponse> invoke(String email) {
    return repositoryContract.checkemail(email);
  }
}
