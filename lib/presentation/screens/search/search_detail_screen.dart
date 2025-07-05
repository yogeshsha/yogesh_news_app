import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/presentation/screens/setting/component/common_app_bar_component.dart';
import 'package:newsapp/presentation/widgets/loader.dart';
import 'package:newsapp/presentation/widgets/not_found_common.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import 'package:taboola_sdk/classic/taboola_classic_listener.dart';
import '../../../constants/ads_helps.dart';
import '../../../constants/app_constant.dart';
import '../../../constants/common_model/text_span_model.dart';
import '../../../data/category_data/category_bloc/category_bloc.dart';
import '../../../data/category_data/domain/category_model/all_news_model.dart';
import '../../../data/category_data/domain/report_reason_model.dart';
import '../../../utils/app.dart';
import '../../../utils/image_builder.dart';
import '../../../utils/tabola.dart';
import '../../widgets/ads_widget.dart';
import '../../widgets/qr_code.dart';
import '../../widgets/refresh_widget.dart';
import '../../widgets/rich_text.dart';
import '../home/component/news_list_component.dart';
import '../home/component/selected_component.dart';
import '../news_details/your_news_function.dart';

class SearchDetailScreen extends StatefulWidget {
  final int newsId;

  const SearchDetailScreen({super.key, required this.newsId});

  @override
  State<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends State<SearchDetailScreen> {
  bool isLoading = false;
  bool checkError = true;
  bool currentScreen = true;
  AllNewsModel? newsModel;
  DateTime? updateDate;
  AllNewsModel? storeModel;
  int page = 1;
  int limit = AppConstant.paginationLimit;
  List<AllNewsModel> likedNewsModel = [];
  ScrollController scrollController = ScrollController();
  TaboolaClassicListener? taboolaClassicListener ;


  @override
  void initState() {

    callNewsDetailApi(context);
    super.initState();
  }



  void callInitialCategory(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchInitialCategory());
  }

  void callGetShareApi(BuildContext context) {
    String url = "${widget.newsId}";
    context.read<CategoryBloc>().add(GenerateDeepLinkUrl(url: url));
  }

  void callLikedApi(BuildContext context, AllNewsModel model, bool value) {
    if (AppHelper.checkUser()) {
      storeModel = model;
      String url = "${model.id}";
      Map body = {"like": value};

      context.read<CategoryBloc>().add(BookMarkEvent(url: url, body: body));
    } else {
      AppHelper.navigateToRegister(
          context: context,
          onUserFound: () {
            callLikedApi(context, model, value);
          });
    }
  }

  void callNewsDetailApi(BuildContext context) {
    String screenName = "searchScreenDetail";
    context
        .read<CategoryBloc>()
        .add(FetchNewsDetailEvent(id: widget.newsId, screenName: screenName));
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getAllLikedNewsApi(context,
          pageValue: page + 1, isScroll: true, isLoading: false);
    }
  }

  void addServiceListener() {
    scrollController.addListener(_scrollListener);
  }

  void removeServiceListener() {
    scrollController.removeListener(_scrollListener);
  }

  void getAllLikedNewsApi(BuildContext context,
      {int pageValue = 1, bool isScroll = false, bool isLoading = true}) {
    String url = newsModel != null ? "${newsModel!.id ?? 0}" : "0";
    url = "$url?page=$pageValue&limit=$limit";
    page = pageValue;
    context
        .read<CategoryBloc>()
        .add(GetLikedNewsEvent(url: url, isLoading: isLoading));
  }

  List<Reasons> reasonsModel = [];

  void callGetReportReason(BuildContext context) {
    context.read<CategoryBloc>().add(const GetReportReasonEvent());
  }

  void callPostReportReason(BuildContext context, int newsId, String reason) {
    Map map = {
      "newsId": newsId,
      "reason": reason,
    };
    context.read<CategoryBloc>().add(PostReportReasonEvent(body: map));
  }


  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (currentScreen) {
        if (state is CategoryLoading) {
          isLoading = true;
          checkError = true;
        } else if (state is CategoryInitial) {
          isLoading = false;
          checkError = true;
        } else if (state is CategoryError) {
          categoryError(context, state);
        } else if (state is OtherStatusCodeCategoryLoaded) {
          otherStatusCodeCategory(context, state);
        } else if (state is GetNewsDetailLoaded) {
          getNewsDetailLoaded(context, state);
        } else if (state is BookMarkLoaded) {
          bookMarkLoaded(context, state);
        } else if (state is GetLikedNewsLoaded) {
          getLickedNewsLoaded(context, state);
        } else if (state is ReportReasonLoaded) {
          reportReasonLoaded(context, state);
        } else if (state is PostReportReasonLoaded) {
          postReportReasonLoaded(context, state);
        } else if (state is DeepLinkLoaded) {
          deepLinkLoaded(context, state);
        }
      }
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (newsModel != null)
                  CommonAppBarComponent(
                    title: "Details",
                    showShare: true,
                    isLiked: newsModel!.isLiked == 1,
                    showBookMark: true,
                    onTapShare: () {
                      callGetShareApi(context);
                    },
                    onTapBookmark: (bool value) {
                      callLikedApi(context, newsModel!, value);
                    },
                  ),

                Expanded(
                  child: RefreshComponent(
                    onRefresh: () {
                      callNewsDetailApi(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: mediaWidth,
                      // height: mediaHeight,
                      child: newsModel != null
                          ? SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  if (newsModel!.newsCategory != null)
                                    SelectedComponent(
                                      title: AppHelper.getHindiEnglishText(
                                          newsModel!.newsCategory!.name,
                                          newsModel!.newsCategory!.hindiName),
                                      isSelected: true,
                                      curve: 5,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                    ),
                                  const SizedBox(height: 10),
                                  const TestBanner(adId: AdWidgetUrls.fixedSizeBannerAd),
                                  const SizedBox(height: 10),
                                  TaboolaCustomClass().setListContent(),

                                  SimpleText(
                                    text: AppHelper.getHindiEnglishText(
                                        newsModel!.title,
                                        newsModel!.hindiTitle),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 10),
                                    child: ImageBuilder
                                        .imageBuilderWithoutContainer(
                                            newsModel!.posterImage ?? "",
                                            height: mediaWidth * .50,
                                            width: mediaWidth),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextAll(
                                          text: AppHelper.getDateFormatter(
                                              updateDate ?? DateTime.now()),
                                          weight: FontWeight.w500,
                                          color: ColorsConstants.textGrayColor,
                                          max: 10),
                                      RichTextComponent2(list: [
                                        TextSpanModel(
                                            title:
                                                "${AppHelper.getTotalReviews(newsModel!.views ?? 0).toString()} ",
                                            style: GoogleFonts.poppins(
                                                color: ColorsConstants
                                                    .textGrayColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11)),
                                        TextSpanModel(
                                            title: "Views",
                                            style: GoogleFonts.poppins(
                                                color: ColorsConstants
                                                    .textGrayColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11))
                                      ]),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 15),
                                    child: SimpleText(
                                      text: AppHelper.getHindiEnglishText(
                                          newsModel!.shortDescription,
                                          newsModel!.hindiShortDescription),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    ),
                                  ),
                                  if (!AppHelper.checkIsHindi())
                                    if ((newsModel!.description ?? [])
                                        .isNotEmpty)
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              newsModel!.description!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Html(
                                                data: AppHelper.htmlTrimString(
                                                    newsModel!
                                                            .description![index]
                                                            .val ??
                                                        ""));
                                          }),
                                  if (AppHelper.checkIsHindi())
                                    if ((newsModel!.hindiDescription ?? [])
                                        .isNotEmpty)
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: newsModel!
                                              .hindiDescription!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Html(
                                                data: AppHelper.htmlTrimString(
                                                    newsModel!
                                                            .hindiDescription![
                                                                index]
                                                            .val ??
                                                        ""));
                                          }),
                                  if (likedNewsModel.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 10),
                                      child: SimpleText(
                                        text: "More like this",
                                        style: GoogleFonts.crimsonText(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                    ),
                                  NewsListComponent(
                                      noResultFoundTitle:
                                          AppHelper.getDynamicString(
                                              context, "No Similar News Found"),
                                      onTapList: (AllNewsModel model) async {},
                                      newsList: likedNewsModel,
                                      onTapReport: (newsId) {
                                        if (reasonsModel.isNotEmpty) {
                                          YourNewsFunction
                                              .showReportBottomSheet(
                                            context,
                                            reasonsModel,
                                            (reason) {
                                              callPostReportReason(
                                                  context, newsId, reason);
                                            },
                                          );
                                        }
                                      },
                                      onTapIsBookMark:
                                          (AllNewsModel model, bool value) {
                                        callLikedApi(context, model, value);
                                      },
                                      scrollController: scrollController)
                                ],
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: mediaHeight * .20),
                              child: const NotFoundCommon(
                                showButton: false,
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
            if (isLoading) const Loading()
          ],
        )),
      );
    });
  }

  void otherStatusCodeCategory(
      BuildContext context, OtherStatusCodeCategoryLoaded state) {
    callInitialCategory(context);

    AppHelper.myPrint(
        "----------------- Inside Other Status Code Category -----------");
    if (checkError) {
      checkError = false;
      if (state.details.statusCode == 401 || state.details.statusCode == 403) {
        Map map = {};
        map['check'] = true;
        map['hideSocialLogin'] = false;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/sessionExpired")
              .then((value) => callNewsDetailApi(context));
        });
      } else if (state.details.statusCode == 500) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
              .then((value) => callNewsDetailApi(context));
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.details.message ?? ""));
        });
      }
    }
  }

  void categoryError(BuildContext context, CategoryError state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(
            context, AppConstant.errorMessage(state.message));
      });
    }
    callInitialCategory(context);
  }

  void getNewsDetailLoaded(BuildContext context, GetNewsDetailLoaded state) {
    callInitialCategory(context);
    newsModel = state.details;
    updateDate =
        DateTime.parse(newsModel!.updatedAt ?? DateTime.now().toString())
            .toLocal();
    getAllLikedNewsApi(context);
  }

  void bookMarkLoaded(BuildContext context, BookMarkLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
    });

    if (storeModel != null) {
      if (newsModel != null) {
        if (newsModel!.id == storeModel!.id) {
          newsModel!.isLiked = ((newsModel!.isLiked ?? 1) == 1) ? 0 : 1;
        }
      }
    }
    callInitialCategory(context);
  }

  void getLickedNewsLoaded(BuildContext context, GetLikedNewsLoaded state) {
    AppHelper.myPrint("-----------GetLikedNewsLoaded----------");
    callInitialCategory(context);
    if (page == 1 || page == 0) {
      likedNewsModel = state.details.newsList ?? [];
    } else {
      if (likedNewsModel.isNotEmpty) {
        state.details.newsList!.map((e) => likedNewsModel.add(e)).toList();
      }
    }
    bool isLastPage = (state.details.count ?? 0) <= likedNewsModel.length;

    if (isLastPage) {
      if (scrollController.hasListeners) {
        removeServiceListener();
      }
    } else {
      if (!scrollController.hasListeners) {
        addServiceListener();
      }
    }
    callGetReportReason(context);
  }

  void reportReasonLoaded(BuildContext context, ReportReasonLoaded state) {
    reasonsModel = state.detail.reasons ?? [];
    callInitialCategory(context);
  }

  void deepLinkLoaded(BuildContext context, DeepLinkLoaded state) {
    callInitialCategory(context);
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        QrCodeFunctions.showDialogForQR(
            context: context,
            qrCode: state.details.deepLinkUrl ?? "",
            message:
                "${AppHelper.checkIsHindi() ? (state.details.hindiTitle ?? "") : (state.details.englishTitle ?? "")}\n${AppHelper.checkIsHindi() ? (state.details.hindiDes ?? "") : (state.details.englishDes ?? "")} : ${state.details.message ?? ""}");
      });
    }
  }

  void postReportReasonLoaded(
      BuildContext context, PostReportReasonLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
    });
    callInitialCategory(context);
  }
}
