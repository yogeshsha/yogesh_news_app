
import 'package:either_dart/either.dart';

import '../../../../constants/common_model/api_model.dart';

abstract class SettingsRepository {
  Future<Either<String, ApiModel>> logOutApi(Map? body);
}
