import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/primary_button_component.dart';

import '../../../../constants/colors_constants.dart';
import '../../../../data/notification_data/domain/notification_model/all_notification_model.dart';

class GetDynamicButtonComponent extends StatelessWidget {
  final ActionsModel model;

  const GetDynamicButtonComponent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    if (model.type == "secondary") {
      return PrimaryButtonComponent(
          title: model.title ?? "",
          alignment: null,
          margin: EdgeInsets.zero,
          textColor: Theme.of(context).colorScheme.primary,
          backGroundColor: Theme.of(context).primaryColor,
          onTap: () {});
    }

    return SizedBox(
        child: PrimaryButtonComponent(
            alignment: null,
            margin: EdgeInsets.zero,
            title: model.title ?? "",
            textColor: ColorsConstants.white,
            backGroundColor: ColorsConstants.appColor,
            onTap: () {}));
  }
}
