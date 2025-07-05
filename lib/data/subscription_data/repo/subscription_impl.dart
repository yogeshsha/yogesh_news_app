import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/data/subscription_data/domain/subscription_model/current_subscription_model.dart';
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../../../constants/app_constant.dart';
import '../../../constants/common_model/api_model.dart';
import '../../../utils/app.dart';
import '../domain/repo/subscription_repo_interface.dart';
import '../domain/subscription_model/subscription_models.dart';



class SubscriptionRepositoryImpl implements SubscriptionRepository {

  @override
  Future<Either<SubscriptionMainModel, ApiModel>> getSubscriptionApi(String url) async {
    try {
      String sendUrl =("${ApiConstants.allSubscriptionUrl}$url");

      AppHelper.myPrint("---------- getSubscriptionApi ---------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("---------------------------------------");
      final response = await http
          .get(Uri.parse(sendUrl), headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      });
      AppHelper.myPrint(
          "-------------------- Response getSubscriptionApi ---------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-----------------------------------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final rewards = jsonData as Map<String, dynamic>;
        return Left(SubscriptionMainModel.fromJson(rewards));
      } else {
        return Right(ApiModel(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<String, ApiModel>> addSubscriptionApi(Map body) async {
    try {
      String sendUrl =(ApiConstants.addSubscriptionUrl);
      AppHelper.myPrint("---------- addSubscriptionApi ---------");
      AppHelper.myPrint(body);
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("---------------------------------------");


      final response = await AppHelper.callApi(
        url: sendUrl,
        body: body,
        apiType: "post",
        isJsonEncode: true
      );
      AppHelper.myPrint(
          "------------------ Response addSubscriptionApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

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

  @override
  Future<Either<String, ApiModel>> addFreeSubscriptionApi() async {
    try {
      String sendUrl =(ApiConstants.addFreeSubscriptionApi);
      AppHelper.myPrint("---------- addFreeSubscriptionApi ---------");


      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("---------------------------------------");


      final response = await AppHelper.callApi(
        url: sendUrl,
        apiType: "post",
      );
      AppHelper.myPrint(
          "------------------ Response addFreeSubscriptionApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

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

  @override
  Future<Either<String, ApiModel>> renewSubscriptionApi(Map body) async {
    try {
      String sendUrl =(ApiConstants.renewSubscriptionUrl);
      AppHelper.myPrint("---------- renewSubscriptionApi ---------");
      AppHelper.myPrint(body);
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("---------------------------------------");

      final response = await AppHelper.callApi(
        url: sendUrl,
        body: body,
        apiType: "post",
        isJsonEncode: true
      );
      AppHelper.myPrint(
          "------------------ Response renewSubscriptionApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

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

  @override
  Future<Either<String, ApiModel>> upgradeSubscriptionApi(Map body) async {
    try {
      String sendUrl =(ApiConstants.upgradeSubscriptionApi);
      AppHelper.myPrint("---------- upgradeSubscriptionApi ---------");
      AppHelper.myPrint(body);
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("---------------------------------------");

      final response = await AppHelper.callApi(
        url: sendUrl,
        body: body,
        apiType: "post",
        isJsonEncode: true
      );
      AppHelper.myPrint(
          "------------------ Response upgradeSubscriptionApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

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

  @override
  Future<Either<MyCurrentSubscriptionModel, ApiModel>> getCurrentSubscriptionApi() async {
    try {
      String sendUrl =(ApiConstants.currentSubscriptionUrl);

      AppHelper.myPrint("---------- getCurrentSubscriptionApi ---------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("---------------------------------------");
      final response = await http
          .get(Uri.parse(sendUrl), headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      });
      AppHelper.myPrint(
          "-------------------- Response getCurrentSubscriptionApi ---------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-----------------------------------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final rewards = jsonData as Map<String, dynamic>;
        return Left(MyCurrentSubscriptionModel.fromJson(rewards));
      } else {
        return Right(ApiModel(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      rethrow;
    }
  }
}
