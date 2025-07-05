
import 'package:either_dart/either.dart';

import '../../../../constants/common_model/api_model.dart';
import '../../../login_data/domain/login_model/login_model.dart';
import '../repo/sign_up_repo_interface.dart';

class SignUpUseCase {
  final SignUpRepository signUpRepository;
  SignUpUseCase({required this.signUpRepository});
  Future<Either<LoginModel, ApiModel>>  getSignUpApi(Map body) {
    return signUpRepository.getSignUpApi(body);
  }
}
