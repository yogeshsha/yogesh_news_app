import 'package:flutter/material.dart';

import '../../../../data/notification_data/domain/notification_model/notification_type_model.dart';
import '../../../../utils/app.dart';
import '../../home/component/selected_component.dart';

class CategoryComponent extends StatelessWidget {
  final List<NotificationType> notificationCategoryList;
  final NotificationType? selectedCategory;
  final Function(NotificationType) onTap;

  const CategoryComponent(
      {super.key,
      required this.notificationCategoryList,
      required this.selectedCategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if(notificationCategoryList.isNotEmpty && selectedCategory != null){
      return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            primary: false,
            itemCount: notificationCategoryList.length,
            padding: const EdgeInsets.only(left: 0,top: 15,bottom: 10),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              NotificationType model = notificationCategoryList[index];
              String name = AppHelper.getHindiEnglishText(model.name , model.hindiName);
              bool isSelected =  selectedCategory!.id == model.id;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SelectedComponent(
                    alignment: Alignment.center,
                    title: name,
                    onTap: () {
                      onTap(model);
                    },
                    isSelected: isSelected),
              );
        }),
      );
    }
    return const SizedBox();
  }
}
