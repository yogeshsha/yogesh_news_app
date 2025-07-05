import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:newsapp/presentation/screens/like_unlike/like_unlike_widget.dart';
import 'package:newsapp/presentation/templates/template_1.dart';

import '../../constants/ads_helps.dart';
import '../../constants/app_constant.dart';
import '../../data/category_data/domain/category_model/category_model.dart';
import '../../data/infinite_data/infinite_bloc/infinite_bloc.dart';
import '../../utils/app.dart';
import '../widgets/ads_widget.dart';
import '../widgets/fancy_shimmer_image.dart';
import '../widgets/home_widgets.dart';

// ignore: must_be_immutable
class DynamicTemplate extends StatefulWidget {
  List<LatestNews> latest;

  DynamicTemplate({super.key, required this.latest});

  @override
  State<DynamicTemplate> createState() => _DynamicTemplateState();
}

class _DynamicTemplateState extends State<DynamicTemplate> {
  // TextToSpeech tts = TextToSpeech();
  ScrollController controller = ScrollController();
  SessionHelper? sessionHelper;
  final List<OtherNews> _list = [];

  @override
  void initState() {
    super.initState();
    _getData();
    // tts.setRate(0.7);
    // AdsHelper.homeAds.load();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.addListener(_scrollListener);
      }
    });
    initSession();
  }

  int currentPage = 2;

  void initSession() async {
    sessionHelper = await SessionHelper.getInstance(context);
    if (mounted) {
      setState(() {});
    }
  }

  void _getData() {
    _list.clear();
    for (int i = 0; i < widget.latest.length; i++) {
      if (i != 0) {
        if (i % 4 == 0) {
          _list.add(OtherNews(
              type: "GoogleAd",
              widget: const TestBanner(adId: AdWidgetUrls.fixedSizeBannerAd)));
          _list.add(OtherNews(type: "", widget: widget.latest[i]));
        } else {
          _list.add(OtherNews(type: "", widget: widget.latest[i]));
        }
      } else {
        _list.add(OtherNews(type: "", widget: widget.latest[i]));
      }
    }
  }

  void _scrollListener() {
    if (controller.position.pixels > controller.position.maxScrollExtent / 2) {
      fetchData(); // Fetch more data
    }
  }

  Future<void> fetchData() async {
    BlocProvider.of<InfiniteBloc>(context)
        .add(FetchInfinite(page: currentPage.toString(), limit: '10'));
    controller.removeListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: BlocBuilder<InfiniteBloc, InfiniteState>(builder: (context, state) {
        if (state is InfiniteLoaded) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context
                  .read<InfiniteBloc>()
                  .add(FetchInitialInfinite(limit: "", page: ""));
            }
            if (state.infinite.isNotEmpty) {
              // setState(() {
              for (int i = 0; i < state.infinite.length; i++) {
                _list.add(
                    OtherNews(
                        widget: state.infinite[i], type: ""));
              }
                // widget.latest.addAll(state.infinite);
                currentPage += 1;
              // });
              controller.addListener(_scrollListener);
            } else {
              controller.removeListener(_scrollListener);
            }
          });
        } else if (state is InfiniteError) {
          AppHelper.myPrint("------------- Error in Infinite Dynamic Screen --------------");
          AppHelper.myPrint(state.message);
          AppHelper.myPrint("---------------------------");
        }

        return StaggeredGridView.countBuilder(
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          shrinkWrap: true,
          itemCount: _list.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (_list[index].type != "GoogleAd") {
              return Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: fancyShimmerImageWidget(
                          _list[index].widget.posterImage,
                          radius: BorderRadius.circular(10))),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/details",
                          arguments: _list[index].widget.id.toString());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // Image border
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 0,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),

                        // padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Spacer(),
                            text1(AppHelper.getHindiEnglishText(_list[index].widget.newsCategory!.name,_list[index].widget.newsCategory!.hindiName),
                                context),
                            const SizedBox(
                              height: 6,
                            ),
                            text2(_list[index].widget.title!),
                            const SizedBox(
                              height: 6,
                            ),
                            text1( AppHelper.dateChange(_list[index].widget.createdAt!),
                                context),
                          ],
                        ),
                      ),
                    ),
                  ),
                  sessionHelper == null
                      ? const SizedBox()
                      : sessionHelper!.get(SessionHelper.userId) == null
                          ? const SizedBox()
                          : Positioned(
                              right: 0,
                              top: 0,
                              child: LikeUnlikeWidget(
                                  id: _list[index].widget.id.toString(),
                                  isLiked: const [],
                                  remove: null),
                            ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.volume_up_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // tts.speak(
                          //   _list[index].widget.title!,
                          // );
                        },
                      )),
                ],
              );
            } else {
              return _list[index].widget;
            }
          },
          crossAxisCount: 2,
          // staggeredTileBuilder: (int index) => new StaggeredTile.count(2),
          staggeredTileBuilder: (int index) {
            if (_list[index].type != "GoogleAd") {
              return const StaggeredTile.count(1, 1.3);
            } else {
              return const StaggeredTile.count(2, 0.3);
            }
            // return StaggeredTile.count(1, 1);
          },
        );
        // return Container(
        //   padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).cardColor,
        //   ),
        //   child: GridView.builder(
        //     shrinkWrap: true,
        //     padding: EdgeInsets.zero,
        //     controller: controller,
        //     physics: const BouncingScrollPhysics(),
        //     itemCount: widget.latest.length,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2, // Number of columns
        //         mainAxisSpacing: 12, // Spacing between rows
        //         crossAxisSpacing: 12, // Spacing between columns
        //         childAspectRatio: 80 / 100),
        //     itemBuilder: (BuildContext context, int index) {
        //       return Stack(
        //         children: [
        //           Positioned(
        //               top: 0,
        //               left: 0,
        //               right: 0,
        //               bottom: 0,
        //               child: fancyShimmerImageWidget(
        //                   widget.latest[index].posterImage,
        //                   radius: BorderRadius.circular(10))),
        //           InkWell(
        //             onTap: () {
        //               Navigator.pushNamed(context, "/details",
        //                   arguments: widget.latest[index].id.toString());
        //             },
        //             child: Container(
        //               width: MediaQuery.of(context).size.width / 2,
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(10),
        //                   // Image border
        //                   boxShadow: const [
        //                     BoxShadow(
        //                       color: Colors.black38,
        //                       blurRadius: 0,
        //                     ),
        //                   ]),
        //               child: Padding(
        //                 padding: const EdgeInsets.symmetric(
        //                     horizontal: 18, vertical: 12),
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     const Spacer(),
        //                     text1(widget.latest[index].newsCategory!.name!,
        //                         context),
        //                     const SizedBox(
        //                       height: 6,
        //                     ),
        //                     text2(widget.latest[index].title!),
        //                     const SizedBox(
        //                       height: 6,
        //                     ),
        //                     text1(dateChange(widget.latest[index].createdAt!),
        //                         context),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //           sessionHelper == null
        //               ? const SizedBox()
        //               : sessionHelper!.get(SessionHelper.USER_ID) == null
        //                   ? const SizedBox()
        //                   : Positioned(
        //                       right: 0,
        //                       top: 0,
        //                       child: LikeUnlikeWidget(
        //                           id: widget.latest[index].id.toString(),
        //                           isLiked: [],
        //                           remove: null),
        //                     ),
        //           Positioned(
        //               top: 0,
        //               left: 0,
        //               child: IconButton(
        //                 icon: const Icon(
        //                   Icons.volume_up_outlined,
        //                   color: Colors.white,
        //                 ),
        //                 onPressed: () {
        //                   tts.speak(
        //                     widget.latest[index].title!,
        //                   );
        //                 },
        //               )),
        //         ],
        //       );
        //     },
        //   ),
        // );
      }),
    );
  }
}
