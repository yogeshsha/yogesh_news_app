import 'package:either_dart/either.dart';
import '../../../constants/api_constants.dart';
import '../../../constants/common_model/api_model.dart';
import '../../../utils/app.dart';
import '../domain/repo/settings_repo_interface.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  @override
  Future<Either<String, ApiModel>> logOutApi(Map? body) async {
    String sendUrl = ApiConstants.logOutUrl;

    try {
      AppHelper.myPrint(
          "--------------------- Value LogOutApi -----------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint(body);
      AppHelper.myPrint("--------------------------------------------");
      final response = await AppHelper.callApi(
          url: sendUrl, body: body, apiType: "post", isJsonEncode: true);

      AppHelper.myPrint(
          "--------------------- Response LogOutApi -----------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("--------------------------------------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Left(response.body);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }
}
