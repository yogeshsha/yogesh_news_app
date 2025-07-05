import 'package:either_dart/either.dart';

import '../../../../constants/common_model/api_model.dart';
import '../../../login_data/domain/login_model/login_model.dart';


abstract class SignUpRepository {
  Future<Either<LoginModel, ApiModel>>  getSignUpApi(Map body);
}
