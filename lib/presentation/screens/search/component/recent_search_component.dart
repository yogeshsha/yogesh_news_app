import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/constants/common_model/store_search_model.dart';
import 'package:newsapp/presentation/widgets/not_found_common.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';

class RecentSearchComponent extends StatelessWidget {
  final List<StoreSearchModel> searchList;

  final Function(StoreSearchModel) onRemoveSearch;

  const RecentSearchComponent(
      {super.key, required this.searchList, required this.onRemoveSearch});

  @override
  Widget build(BuildContext context) {
    double mediaHeight = MediaQuery.of(context).size.height;

    if (searchList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SimpleText(
                text: "Recent Search",
                style: GoogleFonts.crimsonText(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: ColorsConstants.titleColor)),

            ListView.builder(
                itemCount: searchList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  StoreSearchModel model = searchList[index];
                  String title = model.title;

                  bool isLastIndex = index == (searchList.length - 1);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.watch_later_outlined,
                              color: ColorsConstants.textGrayColor, size: 20),
                          const SizedBox(width: 5),
                          Expanded(child: SimpleText(text: title,style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500, fontSize: 14,color: ColorsConstants.textGrayColor))),
                          IconButton(onPressed: () {
                            onRemoveSearch(model);
                          },
                              icon: Icon(
                                  Icons.close,
                                  color: ColorsConstants.textGrayColor,
                                  size: 18))
                        ],
                      ),
                      if(!isLastIndex)
                        Divider(color: ColorsConstants.textGrayColorLightThree),
                    ],
                  );
                }),
            const SizedBox(height: 50)
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: mediaHeight*.20),
      child: const NotFoundCommon(showButton: false,),
    );
  }
}
