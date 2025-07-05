import 'package:flutter/material.dart';
import 'package:newsapp/presentation/screens/home/component/selected_component.dart';

import '../../../../utils/image_builder.dart';
import '../../../widgets/popup_menu_button.dart';
import 'card_title_sub_title_component.dart';

class NewsCardComponent extends StatelessWidget {
  final String image;
  final String? categoryName;
  final int userViews;
  final DateTime? time;
  final String title;
  final String? dropDownTitle;
  final Function(String) onSelectionChange;

  final List<DropdownMenuItem<String>> list;

  const NewsCardComponent(
      {super.key,
      required this.categoryName,
      required this.title,
      required this.userViews,
      required this.time,
      required this.image,
      required this.onSelectionChange,
      required this.list,
      this.dropDownTitle});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.onSurfaceVariant),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if ((categoryName ?? "").isNotEmpty)
                  SelectedComponent(
                    title: categoryName ?? "",
                    isSelected: true,
                    curve: 5,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  ),
                const SizedBox(height: 10),
                TitleSubTitleComponent(
                    title: title, userViews: userViews, time: time)
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (list.isNotEmpty)
                PopUpMenuButtonComponent(
                    list: list,
                    onSelectionChange: onSelectionChange,
                    title: dropDownTitle ?? ""),
              Container(
                  constraints:
                      BoxConstraints(maxWidth: width / 3, maxHeight: width / 3),
                  child: ImageBuilder.imageBuilderWithoutContainer(image)),
            ],
          )
        ],
      ),
    );
  }
}
