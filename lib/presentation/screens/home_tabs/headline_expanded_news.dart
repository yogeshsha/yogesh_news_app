import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/headline_expanded_news_widgets.dart';

import '../../../data/breaking_news_data/domain/breaking_model/breaking_model.dart';
import '../../../utils/app.dart';
import '../../../utils/app_localization.dart';


// ignore: must_be_immutable
class HeadLineExpandedNews extends StatefulWidget {
  List<BreakingNewsModel> data;
  String image;

  HeadLineExpandedNews({super.key, required this.data, required this.image});

  @override
  State<HeadLineExpandedNews> createState() => _HeadLineExpandedNewsState();
}

class _HeadLineExpandedNewsState extends State<HeadLineExpandedNews>{
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBarWithBackLogoCenterImage(context,AppLocalizations.of(context)!.translate("Headline")),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          thickness: 5,
          radius: const Radius.circular(5),
          child: ListView.builder(
            controller: scrollController,
            itemCount: widget.data.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 15,
                          width: 2,
                          color: index == 0 ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 2,
                            color: Colors.grey,
                          ),
                        ),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppHelper.dateChange3(widget.data[index].createdAt!),
                            // widget.data[index].createdAt!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color),
                          ),
                          // Text(
                          //   widget.data[index].title!,
                          //   style: TextStyle(
                          //       color: Theme.of(context)
                          //           .textTheme
                          //           .displayLarge!
                          //           .color,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 18),
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/1.2,
                            child: Text(
                              widget.data[index].shortDescription!,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
