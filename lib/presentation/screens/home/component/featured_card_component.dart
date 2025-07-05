import 'package:flutter/material.dart';
import 'package:newsapp/presentation/screens/home/component/bookmark_component.dart';
import '../../../../utils/image_builder.dart';
import 'card_title_sub_title_component.dart';

class FeaturedCardComponent extends StatelessWidget {
  final String image;
  final String title;
  final int userViews;
  final DateTime? time;
  final bool isBookMarked;
  final Function onTapIsBookMark;

  const FeaturedCardComponent(
      {super.key,
      required this.image,
      required this.title,
      required this.userViews,
      required this.time,
      required this.isBookMarked,
      required this.onTapIsBookMark});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.55,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageBuilder.imageBuilder4(image,
                  width: width * 0.65, height: 200),
              const SizedBox(height: 10),
              TitleSubTitleComponent(
                  title: title, userViews: userViews, time: time)
            ],
          ),
          Positioned(
              top: 8,
              right: 8,
              child: BookMarkComponent(
                  onTapIsBookMark: onTapIsBookMark, isBookMarked: isBookMarked))
        ],
      ),
    );
  }
}
