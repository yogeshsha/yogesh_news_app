import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/constants/common_model/api_model.dart';
import 'package:newsapp/data/login_data/domain/login_model/login_model.dart';
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../../../constants/app_constant.dart';
import '../../../utils/app.dart';
import '../domain/repo/session_repo_interface.dart';

class SessionRepositoryImpl implements SessionRepository {
  @override
  Future<Either<LoginModel,ApiModel>> getSessionApi() async {
    try {

      String sendUrl = ApiConstants.refreshTokenUrl;
      AppHelper.myPrint("--------------------- Value getSessionApi --------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint({
        "refreshToken" : SessionHelper().get(SessionHelper.refreshToken)
      });
      AppHelper.myPrint("-----------------------------------------");
      final response =
          await http.post(Uri.parse(sendUrl), body: {
            "refreshToken" : SessionHelper().get(SessionHelper.refreshToken),
            "role" : "customer"
          },headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      });
      AppHelper.myPrint("------- response getSessionApi -----------");
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-----------------------------------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final categoryList1 = jsonData as Map<String, dynamic>;
        return Left(LoginModel.fromJson(categoryList1));
      } else {
        return Right(ApiModel(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      rethrow;
    }
  }
}
