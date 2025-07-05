
import 'package:either_dart/either.dart';

import '../../../../constants/common_model/api_model.dart';
import '../notification_model/all_notification_model.dart';
import '../notification_model/notification_type_model.dart';
import '../repo/notification_repo_interface.dart';


class  NotificationUseCase {
  final  NotificationRepository  notificationRepository;

  NotificationUseCase({required this.notificationRepository});

  Future<Either<List<NotificationType>,ApiModel>> notificationTypeApi(String url) {
    return notificationRepository.notificationTypeApi(url);
  }
  Future<Either<List<AllNotificationModel>,ApiModel>> allNotificationApi(String url) {
    return notificationRepository.allNotificationApi(url);
  }
  Future<Either<String,ApiModel>> deleteNotificationApi(Map body) {
    return notificationRepository.deleteNotificationApi(body);
  }






}