
import 'package:either_dart/either.dart';

import '../../../../constants/common_model/api_model.dart';
import '../login_model/login_model.dart';

abstract class LoginRepository {
  Future<Either<LoginModel, ApiModel>> getLoginApi(Map body);
}
