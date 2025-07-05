

import 'package:either_dart/either.dart';
import 'package:newsapp/constants/common_model/api_model.dart';
import 'package:newsapp/data/login_data/domain/login_model/login_model.dart';
import '../repo/splash_repo_interface.dart';


class SplashUseCase {
  final SplashRepository splashRepository;
  SplashUseCase({required this.splashRepository});
  Future<Either<LoginModel,ApiModel>> getBasicInfoUser() {
    return splashRepository.getBasicInfoUser();
  }
}
