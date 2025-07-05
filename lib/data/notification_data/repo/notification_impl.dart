import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/constants/common_model/api_model.dart';
import '../../../constants/api_constants.dart';
import '../../../constants/app_constant.dart';
import '../../../utils/app.dart';
import '../domain/notification_model/all_notification_model.dart';
import '../domain/notification_model/notification_type_model.dart';
import '../domain/repo/notification_repo_interface.dart';


class NotificationRepositoryImpl implements NotificationRepository {

  @override
  Future<Either<List<NotificationType>,ApiModel>> notificationTypeApi(String url) async {
    try {
      String sendUrl = "${ApiConstants.getNotificationTypeApi}$url";
      AppHelper.myPrint("------------------ notificationTypeApi------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("------------------------------");

      final response = await http.get(Uri.parse(sendUrl), headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      } );

      AppHelper.myPrint("------------------ Response  notificationTypeApi------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final tempData = jsonData as List<dynamic>;
        final list = tempData;
        List<NotificationType> tempList = [];
        for (int i = 0; i < list.length; i++) {
          tempList.add(NotificationType.fromJson(list[i]));
        }
        return Left(tempList);
      } else {
        return Right(ApiModel(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<Either<List<AllNotificationModel>,ApiModel>> allNotificationApi(String url)async {
    try {
      String sendUrl ="${ApiConstants.allNotificationApi}$url";
      AppHelper.myPrint("------------------ Value allNotificationApi------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("------------------------------");

      final response = await http.get(Uri.parse(sendUrl), headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      } );

      AppHelper.myPrint("------------------ Response allNotificationApi ------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final data = jsonData as Map;

        final List list =  data["rows"] ?? [];
        List<AllNotificationModel> tempList = [];
        for (int i = 0; i < list.length; i++) {
          tempList.add(AllNotificationModel.fromJson(list[i]));
        }
        return Left(tempList);
      } else {
        return Right(ApiModel(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<Either<String,ApiModel>> deleteNotificationApi(Map body)async {
    try {
      String sendUrl = ApiConstants.deleteNotificationApi;
      AppHelper.myPrint("------------------ Value deleteNotificationApi------------");
      AppHelper.myPrint(body);
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("------------------------------");

      final response = await http.put(Uri.parse(sendUrl),body: json.encode(body), headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
        "content-type": "application/json",
      } );

      AppHelper.myPrint("------------------ Response deleteNotificationApi ------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Left(response.body);
      } else {
        return Right(ApiModel(
            statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

}
