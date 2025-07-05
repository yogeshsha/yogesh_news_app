

import 'package:either_dart/either.dart';

import '../../../../constants/common_model/api_model.dart';
import '../repo/settings_repo_interface.dart';

class SettingsUseCase {
  final SettingsRepository settingsRepository;
  SettingsUseCase({required this.settingsRepository});
  Future<Either<String, ApiModel>> logOutApi(Map? body) {
    return settingsRepository.logOutApi(body);
  }
}
