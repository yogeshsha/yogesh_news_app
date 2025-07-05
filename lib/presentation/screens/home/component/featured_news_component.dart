import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/screens/home/component/featured_card_component.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/utils/app.dart';
import 'package:newsapp/utils/date_formatter.dart';

import '../../../../data/category_data/domain/category_model/all_news_model.dart';

class FeaturedNewsComponent extends StatelessWidget {
  final List<AllNewsModel> featuredNews;

  final Function(AllNewsModel, bool) onTapIsBookMark;
  final Function(AllNewsModel) onTap;

  const FeaturedNewsComponent(
      {super.key,
      required this.featuredNews,
      required this.onTapIsBookMark,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (featuredNews.isNotEmpty) {
      double width = MediaQuery.of(context).size.width;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SimpleText(
                    text: "Trending News",
                    style: GoogleFonts.crimsonText(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.secondary)),
                SimpleText(
                    text: DateFormatter.getTodayDayMonthYear(
                        context, DateTime.now()),
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          SizedBox(
            height: 280,
            width: width,
            child: ListView.builder(
                primary: false,
                itemCount: featuredNews.length,
                padding: const EdgeInsets.only(left: 15),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  AllNewsModel model = featuredNews[index];
                  String image = model.posterImage ?? "";
                  String title = AppHelper.getHindiEnglishText(
                      model.title  , model.hindiTitle  );
                  int userViews = 0;
                  DateTime? time = DateTime.tryParse(model.updatedAt ?? "");
                  bool isBookMarked = model.isLiked == 1;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWellCustom(
                      onTap: () {
                        onTap(model);
                      },
                      child: FeaturedCardComponent(
                          onTapIsBookMark: () {
                            onTapIsBookMark(model, !isBookMarked);
                          },
                          isBookMarked: isBookMarked,
                          image: image,
                          title: title,
                          userViews: userViews,
                          time: time),
                    ),
                  );
                }),
          ),
          Divider(color: Theme.of(context).colorScheme.surface)
        ],
      );
    }
    return const SizedBox();
  }
}
