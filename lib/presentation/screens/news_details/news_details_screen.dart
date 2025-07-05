import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/presentation/screens/setting/component/common_app_bar_component.dart';
import 'package:newsapp/presentation/widgets/loader.dart';
import 'package:newsapp/presentation/widgets/not_found_common.dart';
import 'package:newsapp/presentation/widgets/qr_code.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';

import '../../../constants/ads_helps.dart';
import '../../../constants/app_constant.dart';
import '../../../data/category_data/category_bloc/category_bloc.dart';
import '../../../data/category_data/domain/category_model/all_news_model.dart';
import '../../../utils/app.dart';
import '../../../utils/image_builder.dart';
import '../../widgets/ads_widget.dart';
import '../../widgets/refresh_widget.dart';
import '../home/component/selected_component.dart';

class NewsDetailScreen extends StatefulWidget {
  final int newsId;

  const NewsDetailScreen({super.key, required this.newsId});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
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

  @override
  void initState() {
    callYourNewsDetailApi(context);
    super.initState();
  }

  void callInitialCategory(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchInitialCategory());
  }

  void callGetShareApi(BuildContext context) {
    String url = "${widget.newsId}";
    context.read<CategoryBloc>().add(GenerateDeepLinkUrl(url: url));
  }

  void callYourNewsDetailApi(BuildContext context) {
    String screenName = "YourNewsDetail";
    context
        .read<CategoryBloc>()
        .add(FetchNewsDetailEvent(id: widget.newsId, screenName: screenName));
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
                CommonAppBarComponent(
                  title: "Details",
                  showShare: true,
                  showBookMark: false,
                  onTapShare: () {
                    callGetShareApi(context);
                  },
                ),
                Expanded(
                  child: RefreshComponent(
                    onRefresh: () {
                      callYourNewsDetailApi(context);
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: mediaWidth,
                        height: mediaHeight,
                        child: newsModel != null
                            ? Column(
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
                                  SimpleText(
                                    text: AppHelper.getHindiEnglishText(
                                        newsModel!.title,
                                        newsModel!.hindiTitle),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
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
                                  TextAll(
                                      text: AppHelper.getDateFormatter(
                                          updateDate ?? DateTime.now()),
                                      weight: FontWeight.w500,
                                      color: ColorsConstants.textGrayColor,
                                      max: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 15),
                                    child: SimpleText(
                                      text: AppHelper.getHindiEnglishText(
                                          newsModel!.shortDescription,
                                          newsModel!.hindiShortDescription),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: ColorsConstants.textGrayColor),
                                    ),
                                  ),
                                ],
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.only(top: mediaHeight * .20),
                                child: const NotFoundCommon(
                                  showButton: false,
                                ),
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
              .then((value) => callYourNewsDetailApi(context));
        });
      } else if (state.details.statusCode == 500) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
              .then((value) => callYourNewsDetailApi(context));
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
    // getAllLikedNewsApi(context);
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
}
