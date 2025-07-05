import 'package:flutter/material.dart';

import '../../../../data/notification_data/domain/notification_model/all_notification_model.dart';
import '../../../../utils/app.dart';
import 'chat_template_component.dart';

class NotificationComponent extends StatelessWidget {
  final AllNotificationModel notification;

  const NotificationComponent({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    switch (notification.type) {
      case "chat":
        {
          if (notification.data != null) {
            return ChatTemplateComponent(
                image: notification.data!.imageUrl ?? "",
                actions: notification.actions ?? [],
                title: notification.data!.title ?? "",
                message: notification.data!.subTitle ?? "",
                time: AppHelper.calculateTimeAgo(context,
                    DateTime.tryParse(notification.createdAt ?? "") ??
                        DateTime.now()));
          }
          break;
        }
      case "booking":
        {
          if (notification.data != null) {
            return ChatTemplateComponent(
              actions: notification.actions ?? [],
                image: notification.data!.imageUrl ?? "",
                title: notification.data!.title ?? "",
                message: notification.data!.subTitle ?? "",
                time: AppHelper.calculateTimeAgo(context,
                    DateTime.tryParse(notification.createdAt ?? "") ??
                        DateTime.now()));
          }
          break;
        }
    }

    return const SizedBox();
  }
}
