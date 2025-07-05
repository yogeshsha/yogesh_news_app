


import 'package:either_dart/either.dart';
import 'package:newsapp/data/notification_data/domain/notification_model/all_notification_model.dart';

import '../../../../constants/common_model/api_model.dart';
import '../notification_model/notification_type_model.dart';

abstract class NotificationRepository {
  Future<Either<List<NotificationType>,ApiModel>> notificationTypeApi(String url);
  Future<Either<List<AllNotificationModel>,ApiModel>> allNotificationApi(String url);
  Future<Either<String,ApiModel>> deleteNotificationApi(Map body);

}
