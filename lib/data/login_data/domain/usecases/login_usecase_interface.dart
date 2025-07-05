

import 'package:either_dart/either.dart';

import '../../../../constants/common_model/api_model.dart';
import '../login_model/login_model.dart';
import '../repo/login_repo_interface.dart';

class LoginUseCase {
  final LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});
  Future<Either<LoginModel, ApiModel>> getLoginApi(Map body) {
    return loginRepository.getLoginApi(body);
  }
}
