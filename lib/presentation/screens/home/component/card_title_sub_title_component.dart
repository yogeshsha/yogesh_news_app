import 'package:flutter/material.dart';

import '../../../../constants/colors_constants.dart';
import '../../../../utils/app.dart';
import '../../../widgets/dot_component.dart';
import '../../../widgets/simple_text.dart';

class TitleSubTitleComponent extends StatelessWidget {
  final String title;
  final int? maxLines;
  final int userViews;
  final DateTime? time;

  const TitleSubTitleComponent(
      {super.key,
      required this.title,
      this.maxLines,
      required this.userViews,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SimpleText(
            text: title,
            weight: FontWeight.w600,
            maxLines: maxLines ?? 2,
            textOverflow: TextOverflow.ellipsis),
        const SizedBox(height: 5),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SimpleText(
              text: "${AppHelper.getTotalReviews(userViews)} ${AppHelper.getDynamicString(context, "views")}",
              weight: FontWeight.w500,
              size: 10,
              color: ColorsConstants.descriptionColor,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: DotComponent(size: 4),
            ),
            SimpleText(
              text: time == null ? "-" : AppHelper.calculateTimeAgo(context,time!),
              weight: FontWeight.w500,
              size: 10,
              color: ColorsConstants.descriptionColor,
            ),
          ],
        )
      ],
    );
  }
}
