import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/data_source/auth_remote_data_source_impl.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/repository/auth_repository_impl.dart';
import 'package:graduation_project/auth/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:graduation_project/auth/domain/use_case/checkemail_use_case.dart';
import 'package:graduation_project/auth/domain/use_case/login_use_case.dart';
import 'package:graduation_project/auth/domain/use_case/register_use_case.dart';

AuthRepositoryImpl injectAuthRepositoryContract() {
  return AuthRepositoryImpl(remoteDataSource: injectAuthRemoteDataSource());
}

AuthRemoteDataSource injectAuthRemoteDataSource() {
  print(injectAuthRemoteDataSource());

  return AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}

LoginUseCase injectLoginUseCase() {
  return LoginUseCase(repositoryContract: injectAuthRepositoryContract());
}

CheckEmailUseCase injectCheckEmailUseCase() {
  return CheckEmailUseCase(repositoryContract: injectAuthRepositoryContract());
}

RegisterUseCase injectRegisterUseCase() {
  return RegisterUseCase(repositoryContract: injectAuthRepositoryContract());
}
