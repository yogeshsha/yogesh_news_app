import 'package:either_dart/either.dart';
import 'package:newsapp/constants/common_model/api_model.dart';
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../../../constants/app_constant.dart';
import '../../../utils/app.dart';
import '../../login_data/domain/login_model/login_model.dart';
import '../domain/repo/splash_repo_interface.dart';

class SplashRepositoryImpl implements SplashRepository {
  @override
  Future<Either<LoginModel, ApiModel>> getBasicInfoUser() async{
    try {
      String sendUrl = ApiConstants.authUrl;
      AppHelper.myPrint("---------------------  getBasicInfoUser --------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint(SessionHelper().get(SessionHelper.userId));
      AppHelper.myPrint("-----------------------------------------");
      final response = await  AppHelper.callApi(url: sendUrl,tokenRequired: true, apiType: "post");
      AppHelper.myPrint("---------------------response getBasicInfoUser--------------------");
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-----------------------------------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Left(LoginModel.fromJson(jsonDecode(response.body)));
      }
      else {
        return Right(ApiModel(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      rethrow;
    }
  }
}
