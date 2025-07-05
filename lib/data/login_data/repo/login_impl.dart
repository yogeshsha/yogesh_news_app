import 'package:either_dart/either.dart';
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../../../constants/common_model/api_model.dart';
import '../../../utils/app.dart';
import '../domain/login_model/login_model.dart';
import '../domain/repo/login_repo_interface.dart';



class LoginRepositoryImpl implements LoginRepository {

  @override
  Future<Either<LoginModel, ApiModel>> getLoginApi(Map body) async {
    String sendUrl = ApiConstants.loginUrl;

    try {
     AppHelper.myPrint("--------------------- Value Login Screen -----------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint(body);
      AppHelper.myPrint("--------------------------------------------");
      final response = await AppHelper.callApi(url: sendUrl,body: body,apiType: "post",isJsonEncode: true,tokenRequired: false);

      AppHelper.myPrint("--------------------- Response Login Screen -----------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("--------------------------------------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as Map<String ,dynamic>;
        return Left(LoginModel.fromJson(details));
      } else {
        return Right(ApiModel(
            message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }


}
