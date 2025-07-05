import 'package:flutter/material.dart';
import '../../../../constants/colors_constants.dart';
import '../../../../data/notification_data/domain/notification_model/all_notification_model.dart';
import '../../../widgets/not_found_common.dart';
import 'dismissible_component.dart';
import 'notification_component.dart';

class AllNotificationScreen extends StatelessWidget {
  final List<AllNotificationModel> allNotificationList;
  final ScrollController scrollController;
  final Function(int,int) onDismissed;

  const AllNotificationScreen(
      {super.key,
      required this.allNotificationList,
      required this.scrollController,
      required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    if (allNotificationList.isEmpty) {
      return const Center(
          child: NotFoundCommon(text: "Notification", showButton: false));
    }

    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
          itemCount: allNotificationList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            AllNotificationModel model = allNotificationList[index];
            int? id = model.id;

            bool isLastIndex = (index == (allNotificationList.length - 1));
            bool showLoader = isLastIndex &&
                scrollController.hasListeners;

            return Column(
              children: [
                DismissibleComponent(
                    onDismissed: () {
                      if (id != null) {
                        onDismissed(id,index);
                      }
                    },
                    child: NotificationComponent(notification: model)),
                if (showLoader)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: CircularProgressIndicator(
                          color: ColorsConstants.appColor),
                    ),
                  ),

                if(isLastIndex)
                  const SizedBox(height: 110)
              ],
            );
          }),
    );
  }
}
