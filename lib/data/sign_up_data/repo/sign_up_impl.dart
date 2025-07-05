import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../../../constants/common_model/api_model.dart';
import '../../../utils/app.dart';
import '../../login_data/domain/login_model/login_model.dart';
import '../domain/repo/sign_up_repo_interface.dart';


class SignUpRepositoryImpl implements SignUpRepository {
  @override
  Future<Either<LoginModel, ApiModel>> getSignUpApi(Map body) async {

    try {
      String sendUrl = ApiConstants.signUpUrl;
      AppHelper.myPrint("--------------------- Value Sign Up -----------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint(body);
      AppHelper.myPrint("--------------------------------------------");
      final response = await http.post(Uri.parse(sendUrl),
          body: json.encode(body),
          headers: {"content-type": "application/json"});

      AppHelper.myPrint("--------------------- Response Sign Up -----------------------");
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
