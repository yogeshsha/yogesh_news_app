import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/constants/api_constants.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/data/category_data/category_bloc/category_bloc.dart';
import 'package:newsapp/data/category_data/domain/category_model/category_model.dart';
import 'package:newsapp/presentation/screens/breaking_news/breaking_news_screen.dart';
import 'package:newsapp/presentation/screens/like_unlike/like_unlike_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_player/video_player.dart';
import '../../constants/ads_helps.dart';
import '../../constants/colors_constants.dart';
import '../../constants/app_constant.dart';
import '../../data/infinite_data/infinite_bloc/infinite_bloc.dart';
import '../../utils/app.dart';
import '../../utils/custom_chewie_controls.dart';
import '../screens/home/feed_bloc_screen.dart';
import '../widgets/ads_widget.dart';
import '../widgets/fancy_shimmer_image.dart';
import '../widgets/home_widgets.dart';
import '../widgets/skleton_container.dart';
import 'package:chewie/chewie.dart';

class Template1 extends StatefulWidget {
  final  List<LatestNews> feature;
  final  List<LatestNews> latest;
  final  ScrollController controller;
  final  bool checkError;

  const Template1(
      {super.key,
      required this.feature,
      required this.latest,
      required this.controller,
      this.checkError = false});

  @override
  State<Template1> createState() => Template1State();
}

class Template1State extends State<Template1> {
  final List<OtherNews> _list = [];
  int _counter = 0;
  CarouselSliderController buttonCarouselController = CarouselSliderController();
  bool bannerVisible = true;
  bool headlineNews = false;
  bool check2 = false;
  bool check3 = true;
  int currentPage = 2;
  static VideoPlayerController? videoPlayerController;
  late ChewieController chewieController;
  SessionHelperForVideo? sessionHelper;
  SessionHelper? sessionHelper1;
  bool ad1 = false;
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      context.read<CategoryBloc>().add(const FetchCategoryEvent());
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _getData();
    initSession();

    // tts.setRate(0.7);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.controller.hasClients) {
        widget.controller.addListener(_scrollListener);
      }
    });
    if(widget.latest.isEmpty){
      setState(() {
        check3= false;
      });
    }
  }

  Widget? _buildCustomControls(bool check) {
    if (check) {
      return CustomChewieControls(
        controller: videoPlayerController!,
        allowSkipping: false,
        showAds: true,
        callBack: () {
          setState(() {
            chewieController = ChewieController(
                aspectRatio: MediaQuery.of(context).size.width / 250,
                videoPlayerController: videoPlayerController!,
                autoInitialize: true,
                looping: true,
                customControls: _buildCustomControls(false),
                isLive: true);
            videoPlayerController!.play();
          });
        },
      );
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant Template1 oldWidget) {
    _getData();
    super.didUpdateWidget(oldWidget);
  }
  void _getData() {
    _list.clear();
    for (int i = 0; i < widget.feature.length; i++) {
      if (i != 0) {
        if (i % 4 == 0) {
          _list.add(OtherNews(
              type: "GoogleAd",
              widget: const TestBanner(adId: AdWidgetUrls.fixedSizeBannerAd)));
          _list.add(OtherNews(type: "", widget: widget.feature[i]));
        } else {
          _list.add(OtherNews(type: "", widget: widget.feature[i]));
        }
      } else {
        _list.add(OtherNews(type: "", widget: widget.feature[i]));
      }
    }
  }

  void _scrollListener() {
    if (widget.controller.position.pixels >
        widget.controller.position.maxScrollExtent / 2) {
      // Reached the bottom
      fetchData(); // Fetch more data
    }
  }

  Future<void> fetchData() async {
    if (mounted) {
      BlocProvider.of<InfiniteBloc>(context)
          .add(FetchInfinite(page: currentPage.toString(), limit: '10'));
    }
    widget.controller.removeListener(_scrollListener);
  }

  setPlayer() {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(ApiConstants.dummyVideoUrl))..initialize().then((value){
      // videoPlayerController!.play();
      setState(() {});});
    if (sessionHelper != null) {
      videoPlayerController!.setVolume(double.parse(
          sessionHelper!.get(SessionHelperForVideo.isMuted) ?? "1"));
    }
    videoPlayerController!.setVolume(0);
      chewieController = ChewieController(
          aspectRatio: MediaQuery.of(context).size.width / 250,
          videoPlayerController: videoPlayerController!,
          autoInitialize: true,
          autoPlay: true,
          customControls: _buildCustomControls(false),
          isLive: true);
      setState(() {
        check2 = true;
      });
      // Future.delayed(Duration(seconds: 1)).then((value) => videoPlayerController!.play());
    videoPlayerController!.addListener(_checkAdTime);
  }

  void _checkAdTime() {
    if (videoPlayerController!.value.position.inSeconds == 2) {
      chewieController = ChewieController(
          aspectRatio: MediaQuery.of(context).size.width / 250,
          videoPlayerController: videoPlayerController!,
          autoInitialize: true,
          customControls: _buildCustomControls(true),
          isLive: true);
      setState(() {});
      videoPlayerController!.removeListener(_checkAdTime);
    }
  }

  bool before() {
    bool check = true;
    if (videoPlayerController != null) {
      check = videoPlayerController!.value.isPlaying;
      videoPlayerController!.pause();
    }
    return check;
  }

  void after(bool check) {
    if (check) {
      Template1State.videoPlayerController!.play();
    }
  }

  @override
  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController!.pause();
    }
    videoPlayerController!.dispose();
    chewieController.dispose();
    // tts.stop();
    super.dispose();
  }

  void initSession() async {
    sessionHelper = await SessionHelperForVideo.getInstance(context);
    if (mounted) {
      sessionHelper1 = await SessionHelper.getInstance(context);
    }
    setPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SmartRefresher(
        physics: const BouncingScrollPhysics(),
        // controller: widget.controller ,
        scrollController: widget.controller,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        enablePullDown: true,
        controller: _refreshController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BreakingNewsScreen(after: after, before: before),
            //Live TV
            check2
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AspectRatio(
                          aspectRatio: MediaQuery.of(context).size.width / 250,
                          child: Chewie(
                            controller: chewieController,
                          )
                        // child: VideoPlayer(videoPlayerController!),
                      ),
                    ),
                  )
                : const SizedBox(),
            TestBanner(
              adId: AdWidgetUrls.fixedSizeBannerAd,
              height: 400,
              width: MediaQuery.of(context).size.width.toInt(),
              // width: 1000,
            ),

            //Latest News
            Visibility(
              visible: !widget.checkError,
              child: Visibility(
                visible: widget.latest.isNotEmpty,
                replacement: SkeletonContainer(
                    width: MediaQuery.of(context).size.width, height: 370),
                child: Container(
                  // height: 500,
                  width: MediaQuery.of(context).size.width,
                  constraints: const BoxConstraints(maxWidth: 600,maxHeight: 500),

                  child: Stack(
                    children: [
                      CarouselSlider(
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                          onPageChanged: (index, a) {
                            setState(() {
                              _counter = index;
                            });
                          },
                          enableInfiniteScroll: false,
                          autoPlay: true,
                          aspectRatio: 2 / 1.9,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                        ),
                        items: widget.latest.map((e) {
                          // // Here you can find item index.
                          // int idx = listThumbs.indexOf(e);
                          return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(e.posterImage ??
                                        ImagesConstants.errorWidgetImage),
                                    fit: BoxFit.fill)),
                            // padding: const EdgeInsets.symmetric(horizontal: 35),
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child:
                                        fancyShimmerImageWidget(e.posterImage)),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 0,
                                    ),
                                  ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        text4("Latest News"),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(5),
                                            child: Center(
                                                child: text3(e.title!, context))),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            text1("Yogesh Sharma", context),
                                            text1(" | ", context),
                                            text1( AppHelper.dateChange(e.createdAt!),
                                                context),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 35,
                        // width: MediaQuery.of(context).size.width,
                        left: 0,
                        right: 0,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  buttonCarouselController.previousPage();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: _counter != 0
                                      ? Colors.white
                                      : ColorsConstants.arrowColor,
                                  size: 35,
                                )),
                            const SizedBox(
                              width: 30,
                            ),
                            IconButton(
                                onPressed: () {
                                  buttonCarouselController.nextPage();
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: _counter != widget.latest.length - 1
                                      ? Colors.white
                                      : ColorsConstants.arrowColor,
                                  size: 35,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const TestBanner(
              adId: AdWidgetUrls.fixedSizeBannerAd,
            ),
            //Other News
            Visibility(
              visible: !widget.checkError,
              child: Visibility(
                visible: _list.isNotEmpty,
                replacement: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 10,

                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width~/190, // Number of columns
                            mainAxisSpacing: 12, // Spacing between rows

                            // mainAxisExtent: 5,
                            crossAxisSpacing: 12, // Spacing between columns
                            childAspectRatio: 80 / 100),
                    itemBuilder: (BuildContext context, int index) {
                      return SkeletonContainer(
                        width: 80,
                        height: 100,
                        borderRadius: BorderRadius.circular(10),
                      );
                    },
                  ),
                ),
                child: BlocBuilder<InfiniteBloc, InfiniteState>(
                    builder: (context, state) {
                  if (state is InfiniteLoaded) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        context
                            .read<InfiniteBloc>()
                            .add(FetchInitialInfinite(limit: "", page: ""));
                      }
                      if (state.infinite.isNotEmpty) {
                        for (int i = 0; i < state.infinite.length; i++) {
                          _list.add(
                              OtherNews(widget: state.infinite[i], type: ""));
                        }
                        currentPage += 1;
                        widget.controller.addListener(_scrollListener);
                      } else {
                        check3 = false;
                        widget.controller.removeListener(_scrollListener);
                      }
                    });
                  } else if (state is InfiniteError) {}
                  return StaggeredGridView.countBuilder(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,

                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    shrinkWrap: true,
                    itemCount: _list.length,
                    physics: const NeverScrollableScrollPhysics(),

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
                                bool check = before();
                                Navigator.pushNamed(context, "/details",
                                        arguments:
                                            _list[index].widget.id.toString())
                                    .then((value) {
                                  after(check);
                                });
                                // }
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      text1(
                                          _list[index]
                                              .widget
                                              .newsCategory!
                                              .name!,
                                          context),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      text2(_list[index].widget.title!),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      text1(
                                          AppHelper.dateChange(
                                              _list[index].widget.createdAt!),
                                          context),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (sessionHelper != null)
                              if (sessionHelper!.get(SessionHelper.userId) !=
                                  null)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: LikeUnlikeWidget(
                                    isLiked: _list[index].widget.isLiked!,
                                    id: _list[index].widget.id.toString(),
                                    remove: null,
                                  ),
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
                                    if (videoPlayerController != null) {
                                      // setState(() {
                                      videoPlayerController!.setVolume(0);
                                      // });
                                    }
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
                }),
              ),
            ),
            if (!check3)
              FeedBlocScreen(
                after: after,
                before: before,
                url: "https://rss.app/feeds/VYT9X1z6VKHIkS9x.xml",
              ),

            // Container(
            //   padding: const EdgeInsets.symmetric(
            //       vertical: 10, horizontal: 10),
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).cardColor,
            //   ),
            //   child: GridView.builder(
            //     shrinkWrap: true,
            //     padding: EdgeInsets.zero,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: widget.feature.length,
            //     gridDelegate:
            //     const SliverGridDelegateWithFixedCrossAxisCount(
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
            //                   widget.feature[index].posterImage,
            //                   radius: BorderRadius.circular(10))),
            //           InkWell(
            //             onTap: () {
            //               bool check = before();
            //               Navigator.pushNamed(context, "/details",
            //                   arguments:
            //                   widget.feature[index].id.toString())
            //                   .then((value) {
            //                 after(check);
            //               });
            //               // }
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
            //
            //                 // padding: const EdgeInsets.all(18.0),
            //                 child: Column(
            //                   crossAxisAlignment:
            //                   CrossAxisAlignment.start,
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const Spacer(),
            //                     text1(
            //                         widget.feature[index].newsCategory!
            //                             .name!,
            //                         context),
            //                     const SizedBox(
            //                       height: 6,
            //                     ),
            //                     text2(widget.feature[index].title!),
            //                     const SizedBox(
            //                       height: 6,
            //                     ),
            //                     text1(
            //                         dateChange(
            //                             widget.feature[index].createdAt!),
            //                         context),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //           if (sessionHelper != null)
            //             if (sessionHelper!.get(SessionHelper.USER_ID) !=
            //                 null)
            //               Positioned(
            //                 right: 0,
            //                 top: 0,
            //                 child: getLiked(
            //                     widget.feature[index].isLiked!,
            //                     widget.feature[index].id.toString()),
            //                 // child: LikeUnlikeWidget(isLiked: widget.feature[index].isLiked!,id: widget.feature[index].id.toString()),
            //               ),
            //           Positioned(
            //               top: 0,
            //               left: 0,
            //               child: IconButton(
            //                 icon: const Icon(
            //                   Icons.volume_up_outlined,
            //                   color: Colors.white,
            //                 ),
            //                 onPressed: () {
            //                   if (videoPlayerController != null) {
            //                     // setState(() {
            //                     videoPlayerController!.setVolume(0);
            //                     // });
            //                   }
            //                   tts.speak(
            //                     widget.feature[index].title!,
            //                   )
            //                   //     .then((value) {
            //                   //   if (videoPlayerController != null) {
            //                   //     setState(() {
            //                   //       videoPlayerController!.play();
            //                   //     });
            //                   //   }
            //                   // })
            //                       ;
            //                 },
            //               )),
            //         ],
            //       );
            //     },
            //   ),
            // )

            // if (check3)
            //   const SizedBox(
            //     child: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   ),

            // if (_feed != null)
            //   GridView.builder(
            //     shrinkWrap: true,
            //     padding: EdgeInsets.zero,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: _feed!.items!.length,
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2, // Number of columns
            //         mainAxisSpacing: 12, // Spacing between rows
            //         crossAxisSpacing: 12, // Spacing between columns
            //         childAspectRatio: 80 / 100),
            //     itemBuilder: (BuildContext context, int index) {
            //       final item = _feed!.items![index];
            //       return InkWell(
            //         onTap: () {
            //           bool check = before();
            //           Navigator.pushNamed(context, "/webView",
            //                   arguments: item.link)
            //               .then((value) {
            //             after(check);
            //           });
            //         },
            //         child: Container(
            //           width: MediaQuery.of(context).size.width / 2,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               // Image border
            //               boxShadow: const [
            //                 BoxShadow(
            //                   color: Colors.black38,
            //                   blurRadius: 0,
            //                 ),
            //               ]),
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 18, vertical: 12),
            //             // padding: const EdgeInsets.all(18.0),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 const Spacer(),
            //                 // text1(
            //                 //     item.link!,
            //                 //     context),
            //                 const SizedBox(
            //                   height: 6,
            //                 ),
            //                 text2(item.title!),
            //                 const SizedBox(
            //                   height: 6,
            //                 ),
            //                 // text2(item.description ?? ""),
            //                 text1(dateChange2(item.pubDate!), context),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // if (_atomFeed != null)
            //   GridView.builder(
            //     shrinkWrap: true,
            //     padding: const EdgeInsets.only(top: 12),
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: _atomFeed!.items!.length,
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2, // Number of columns
            //         mainAxisSpacing: 12, // Spacing between rows
            //         crossAxisSpacing: 12, // Spacing between columns
            //         childAspectRatio: 80 / 100),
            //     itemBuilder: (BuildContext context, int index) {
            //       final item = _atomFeed!.items![index];
            //       return InkWell(
            //         onTap: () {
            //           bool check = before();
            //           Navigator.pushNamed(context, "/webView",
            //                   arguments: item.id)
            //               .then((value) {
            //             after(check);
            //           });
            //         },
            //         child: Container(
            //           width: MediaQuery.of(context).size.width / 2,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               // Image border
            //               boxShadow: const [
            //                 BoxShadow(
            //                   color: Colors.black38,
            //                   blurRadius: 0,
            //                 ),
            //               ]),
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 18, vertical: 12),
            //             // padding: const EdgeInsets.all(18.0),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 const Spacer(),
            //                 // text1(
            //                 //     item.link!,
            //                 //     context),
            //                 const SizedBox(
            //                   height: 6,
            //                 ),
            //                 text2(item.title!),
            //                 const SizedBox(
            //                   height: 6,
            //                 ),
            //                 // text2(item.content!),
            //                 text1(dateChange2(item.updated!), context),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
          ],
        ),
      ),
    );
  }
}

class OtherNews {
  String? type;
  dynamic widget;

  OtherNews({required this.widget, required this.type});
}

class Headline {
  String title;
  String description;
  DateTime time;

  Headline(
      {required this.title, required this.description, required this.time});
}
