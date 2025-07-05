import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
import 'package:newsapp/presentation/widgets/not_found_common.dart';

import '../../../../constants/colors_constants.dart';
import '../../../../data/category_data/domain/category_model/all_news_model.dart';
import '../../../../utils/app.dart';
import '../../../widgets/text_common.dart';
import 'news_card_component.dart';

class NewsListComponent extends StatelessWidget {
  final List<AllNewsModel> newsList;
  final String? notFoundSubTitle;
  final String? noResultFoundTitle;
  final String? dropDownTitle;
  final Function(AllNewsModel, bool) onTapIsBookMark;
  final Function(int id, String value)? onTapDelete;
  final Function(AllNewsModel) onTapList;
  final Function(int id) onTapReport;
  final ScrollController scrollController;
  final bool? showDeleteOnly;
  final bool showNotFound;

  const NewsListComponent(
      {super.key,
      required this.newsList,
      this.showNotFound = true,
      required this.scrollController,
      required this.onTapIsBookMark,
      this.notFoundSubTitle,
      required this.onTapList,
      this.showDeleteOnly,
      this.onTapDelete,
      this.dropDownTitle,
      required this.onTapReport, this.noResultFoundTitle});

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;

    if (newsList.isNotEmpty) {
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          primary: false,
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int index) {
            AllNewsModel model = newsList[index];
            String title =  AppHelper.getHindiEnglishText(
                model.title  , model.hindiTitle );
            String? categoryName;
            int userViews = model.views ?? 0;
            DateTime? time = DateTime.tryParse(model.updatedAt ?? "");
            String image = model.posterImage ?? "";
            bool showLoader = (index == (newsList.length) - 1) &&
                scrollController.hasListeners;

            if (model.newsCategory != null) {
              categoryName = AppHelper.getHindiEnglishText(model.newsCategory!.name ,model.newsCategory!.hindiName);
            }

            bool isBookMarked = model.isLiked == 1;
            List<DropdownMenuItem<String>> list = [];
            if (showDeleteOnly ?? false) {
              list = [
                DropdownMenuItem(
                    value: "delete",
                    child: TextAll(
                      textDynamic: true,
                      text: "Delete",
                      color: Theme.of(context).colorScheme.secondary,
                      weight: FontWeight.w400,
                      max: 14,
                    )),
                DropdownMenuItem(
                    value: "edit",
                    child: TextAll(
                      textDynamic: true,
                      text: "Edit",
                      color: Theme.of(context).colorScheme.secondary,
                      weight: FontWeight.w400,
                      max: 14,
                    )),
              ];
            } else {
              list = [
                DropdownMenuItem(
                    value: "block",
                    child: TextAll(
                      textDynamic: true,
                      text: "Block",
                      color: Theme.of(context).colorScheme.secondary,
                      weight: FontWeight.w400,
                      max: 14,
                    )),
                DropdownMenuItem(
                    value: "bookmark",
                    child: TextAll(
                      textDynamic: true,
                      text: isBookMarked
                          ? "Remove From Bookmark"
                          : "Add To Bookmark",
                      color: Theme.of(context).colorScheme.secondary,
                      weight: FontWeight.w400,
                      max: 14,
                    )),
                DropdownMenuItem(
                    value: "report",
                    child: TextAll(
                      textDynamic: true,
                      text: "Report",
                      color: Theme.of(context).colorScheme.secondary,
                      weight: FontWeight.w400,
                      max: 14,
                    )),
              ];
            }

            return InkWellCustom(
              onTap: () {
                onTapList(model);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    NewsCardComponent(
                        dropDownTitle: dropDownTitle ?? "",
                        list: list,
                        onSelectionChange: (String value) {
                          if (value == "report") {
                            onTapReport(model.id ?? 0);
                          } else if (value == "bookmark") {
                            onTapIsBookMark(model, !isBookMarked);
                          } else if (value == "block") {
                          } else if (value == "delete") {
                            if (onTapDelete != null) {
                              onTapDelete!(model.id ?? 0, value);
                            }
                          } else if (value == "edit") {
                            if (onTapDelete != null) {
                              onTapDelete!(model.id ?? 0, value);
                            }
                          }
                        },
                        title: title,
                        userViews: userViews,
                        time: time,
                        image: image,
                        categoryName: categoryName),
                    if (showLoader)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: CircularProgressIndicator(
                              color: ColorsConstants.appColor),
                        ),
                      ),
                  ],
                ),
              ),
            );
          });
    }

    if (showNotFound) {
      return Padding(
        padding: EdgeInsets.only(top: mediaHeight * .10),
        child: NotFoundCommon(showButton: false, subTitle: notFoundSubTitle,title:noResultFoundTitle),
      );
    }

    return const SizedBox();
  }
}
