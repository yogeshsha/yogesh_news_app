
import 'package:either_dart/either.dart';
import 'package:newsapp/constants/common_model/api_model.dart';
import 'package:newsapp/data/login_data/domain/login_model/login_model.dart';

abstract class SplashRepository {
  Future<Either<LoginModel,ApiModel>> getBasicInfoUser();
}

