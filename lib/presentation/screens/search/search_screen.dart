import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/presentation/widgets/arrow_back_ios.dart';
import 'package:newsapp/presentation/widgets/refresh_widget.dart';
import 'package:newsapp/presentation/widgets/search_mic_component.dart';
import 'package:newsapp/presentation/widgets/text_form_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../constants/app_constant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/common_model/store_search_model.dart';
import '../../../data/category_data/category_bloc/category_bloc.dart';
import '../../../data/category_data/domain/category_model/all_news_model.dart';
import '../../../data/category_data/domain/category_model/news_category_model.dart';
import '../../../data/category_data/domain/report_reason_model.dart';
import '../../../utils/app.dart';
import '../../../utils/sql_lite.dart';
import '../../widgets/ink_well_custom.dart';
import '../../widgets/loader.dart';
import '../home/component/category_component.dart';
import '../home/component/news_list_component.dart';
import '../news_details/your_news_function.dart';
import '../popups/pop_ups_screen.dart';
import 'component/recent_search_component.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class NewsTab {
  final String name;
  final String imageUrl;
  final Widget widget;

  NewsTab({required this.name, required this.widget, required this.imageUrl});
}

class SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  bool checkError = true;
  AllNewsModel? storeModel;

  List<NewsCategoryModel> categoryList = [];
  List<int> selectedCategoryList = [-1];
  List<AllNewsModel> latestNews = [];

  double height = 50;

  ScrollController scrollController = ScrollController();
  int page = 1;
  int limit = AppConstant.paginationLimit;
  List<StoreSearchModel> recentSearch = [];
  final SpeechToText _speechToText = SpeechToText();
  bool micSearch = false;
  int trackTitle = -1;
  int trackSearch = -1;
  int storeIndex = 0;
  String beforeTextSearch = "";
  bool currentScreen = true;
  @override
  void initState() {
    initApi(context);
    super.initState();
  }
  void _startListening() async {
    String currentLocaleId = 'en_IN';
    _speechToText.cancel();
    setState(() {
      micSearch = true;
    });
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: currentLocaleId,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      if (trackSearch > -1) {
        final newText = beforeTextSearch.replaceRange(
            trackSearch, trackSearch, result.recognizedWords);
        searchController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
              offset: trackSearch + result.recognizedWords.length),
        );
      } else if (beforeTextSearch.isNotEmpty) {
        setState(() {
          searchController = TextEditingController(
              text: "$beforeTextSearch ${result.recognizedWords}");
        });
      } else {
        setState(() {
          searchController =
              TextEditingController(text: result.recognizedWords);
        });
      }
      // callInit(context);
      setState(() {
        micSearch = false;
      });
    } else {
      if (trackSearch > -1) {
        final newText = beforeTextSearch.replaceRange(
            trackSearch, trackSearch, result.recognizedWords);
        searchController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(
              offset: trackSearch + result.recognizedWords.length),
        );
      } else if (beforeTextSearch.isNotEmpty) {
        setState(() {
          searchController = TextEditingController(
              text: "$beforeTextSearch ${result.recognizedWords}");
        });
      } else {
        setState(() {
          searchController =
              TextEditingController(text: result.recognizedWords);
        });
      }
    }
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

  void addServiceListener() {
    scrollController.addListener(_scrollListener);
  }

  void removeServiceListener() {
    scrollController.removeListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      callGetLikedNewsApi(context, pageValue: page + 1, isLoading: false);
    }
  }

  void callInitialCategory(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchInitialCategory());
  }

  void callGetCategoryList(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchCategoryEvent());
  }

  Future<void> callGetLikedNewsApi(BuildContext context,
      {int pageValue = 1, bool isLoading = true}) async {
    if (searchController.text.trim().isEmpty) {
      if (context.mounted) {
        List<Map<String, dynamic>> searchTable =
            await DatabaseHelper().getSearchTable(DatabaseHelper.searchTable);
        recentSearch =
            searchTable.map((file) => StoreSearchModel.fromJson(file)).toList();
        latestNews.clear();

        setState(() {});
        if (context.mounted) {
          callInitialCategory(context);
        }
      }
    } else {
      String url = "";
      url =
          "page=$pageValue&limit=$limit&search=${searchController.text.trim()}";

      List<int> tempSelected = [];

      selectedCategoryList.map((e) {
        if (e > 0) {
          tempSelected.add(e);
        }
      }).toList();

      if (tempSelected.isNotEmpty) {
        url = "$url&newsCategoryId=${tempSelected.join(",")}";
      }

      page = pageValue;
      context
          .read<CategoryBloc>()
          .add(FetchNewsEvent(isLoading: isLoading, url: url));
    }
  }

  void initApi(BuildContext context) {
    callGetCategoryList(context);
  }

  List<Reasons> reasonsModel = [];
  void callGetReportReason(BuildContext context) {
    context.read<CategoryBloc>().add(const GetReportReasonEvent());
  }
  void callPostReportReason(BuildContext context, int newsId,String reason) {
    Map map ={
      "newsId": newsId,
      "reason": reason,
    };
    context.read<CategoryBloc>().add(PostReportReasonEvent(body :map));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
       if(currentScreen) {
          if (state is CategoryLoading) {
            isLoading = true;
            checkError = true;
          } else if (state is CategoryInitial) {
            isLoading = false;
            checkError = true;
          } else if (state is CategoryError) {
            categoryError(context, state);
          } else if (state is NewsCategoryLoaded) {
            categoryLoaded(context, state);
          } else if (state is OtherStatusCodeCategoryLoaded) {
            otherStatusCodeCategory(context, state);
          } else if (state is AllNewsLoaded) {
            allNewsLoaded(context, state);
          } else if (state is BookMarkLoaded) {
            bookMarkLoaded(context, state);
          }else if (state is ReportReasonLoaded) {
            reportReasonLoaded(context, state);
          }else if (state is PostReportReasonLoaded) {
            postReportReasonLoaded(context, state);
          }
       }
      return Stack(
        children: [
          Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SafeArea(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      SearchMicComponent(
                          searchController: searchController,
                          callApi: () {
                            callGetLikedNewsApi(context, isLoading: false);
                          },
                          searchComponent: TextFormFieldWidget(
                            margin: EdgeInsets.zero,
                            borderCurve: 0,
                            borderEnable: false,
                            controller: searchController,
                            validation: (value) => null,
                            hint: "Search Everything",
                            inputFormatters: [
                              AppConstant.denyAndOperator
                            ],
                            prefix:const ArrowBackButton2(),
                            suffix: Padding(
                              padding:const EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Container(
                                      height: 35,
                                      width: 1,
                                      color:( Theme.of(context).colorScheme.onTertiaryContainer).withOpacity(0.4),
                                    ),
                                  ),
                                  InkWellCustom(
                                    onTap: () async {
                                      if (await Permission.microphone.isGranted) {
                                        await _speechToText.initialize();
                                        beforeTextSearch =
                                            searchController.text
                                                .trim();
                                        trackSearch =
                                            searchController
                                                .selection
                                                .baseOffset;
                                        if (micSearch) {
                                          _stopListening();
                                          setState(() {
                                            micSearch = false;
                                          });
                                        } else {
                                          _startListening();
                                        }
                                      } else {
                                        if (context.mounted) {
                                          microPhonePermissionAskPopUp(context, () async {
                                            await Permission.microphone.request().then(
                                                    (value) async {
                                                  if (value.isGranted) {
                                                    await _speechToText.initialize();
                                                    beforeTextSearch =searchController.text.trim();
                                                    trackSearch =searchController.selection.baseOffset;
                                                    if (micSearch) {
                                                      _stopListening();
                                                      setState(() {
                                                        micSearch =false;
                                                      });
                                                    } else {
                                                      _startListening();
                                                    }
                                                  } else {
                                                    if (mounted) {
                                                      AppHelper.showSnakeBar(
                                                      context, AppConstant.errorMessage("Permission Denied"));

                                                      // showSnakeBar(context, "Permission Denied");
                                                    }
                                                  }
                                                });
                                          });
                                        }
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      ImagesConstants.mic2,
                                      colorFilter: AppConstant
                                          .getColorFilter(micSearch
                                          ? Colors.green
                                          : ColorsConstants.appColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 0,
                        child: Divider(
                        ),
                      ),

                      Expanded(
                        child: searchController.text.trim().isEmpty
                            ? SingleChildScrollView(
                          physics:const BouncingScrollPhysics(),

                              child: RecentSearchComponent(
                                  onRemoveSearch: (StoreSearchModel model) async {
                                    if (model.tableId != null) {
                                      await DatabaseHelper().deleteRowSearchTable(
                                          model.tableId ?? 0);
                                      if (context.mounted) {
                                        callGetLikedNewsApi(context);
                                      }
                                    }
                                  },
                                  searchList: recentSearch),
                            )
                            : Column(
                                children: [
                                  CategoryComponent(
                                      categoryList: categoryList,
                                      selectedCategoryList:
                                          selectedCategoryList,
                                      onRemoveList: (int id) {
                                        latestNews.clear();
                                        selectedCategoryList.remove(id);
                                        if (selectedCategoryList.isEmpty) {
                                          selectedCategoryList.add(-1);
                                        }
                                        callGetLikedNewsApi(context);
                                      },
                                      onAddCategory: (int id) {
                                        latestNews.clear();
                                        selectedCategoryList.remove(-1);
                                        selectedCategoryList.add(id);
                                        callGetLikedNewsApi(context);
                                      },
                                      onTapAll: () {
                                        latestNews.clear();
                                        selectedCategoryList.clear();
                                        selectedCategoryList.add(-1);
                                        callGetLikedNewsApi(context);
                                      }),
                                  Expanded(
                                    child: RefreshComponent(
                                      scrollController: scrollController,
                                      onRefresh: () {
                                        initApi(context);
                                      },
                                      child: SingleChildScrollView(
                                        primary: false,
                                        physics: const BouncingScrollPhysics(),
                                        child: NewsListComponent(
                                            onTapList:(AllNewsModel model) async {
                                              // await DatabaseHelper()
                                              //     .createSearch(
                                              //         model: StoreSearchModel(
                                              //             title:
                                              //                 model.title ?? "",
                                              //             subTitle: ""),
                                              //         tableName: DatabaseHelper
                                              //             .searchTable);
                                              // if (context.mounted) {
                                              //   callGetLikedNewsApi(context,isLoading: false);
                                              // }
                                              Map map={
                                                'id':model.id
                                              };
                                              currentScreen = false;
                                              Navigator.pushNamed(context , "/searchDetailScreen",arguments: map).then((value) =>
                                              currentScreen = true);
                                            },
                                            newsList: latestNews,
                                            onTapReport: (newsId){
                                              if(reasonsModel.isNotEmpty) {
                                                YourNewsFunction.showReportBottomSheet(context,reasonsModel,
                                                      (reason){
                                                    callPostReportReason(context,newsId,reason);
                                                  },);
                                              }
                                            },
                                            onTapIsBookMark:(AllNewsModel model,bool value) {
                                              callLikedApi(context, model, value);


                                            },
                                            scrollController: scrollController),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      )
                    ],
                  )),
            ),
          ),
          if (isLoading) const Loading()
        ],
      );
    });
  }

  void categoryLoaded(BuildContext context, NewsCategoryLoaded state) {
    categoryList = state.category;
    categoryList.insert(0, NewsCategoryModel(name: "All", id: -1));
    callGetLikedNewsApi(context);
  }

  void allNewsLoaded(BuildContext context, AllNewsLoaded state) {
    if (page == 1 || page == 0) {
      latestNews = state.newsList.newsList ?? [];
    } else {
      (state.newsList.newsList ?? []).map((e) => latestNews.add(e)).toList();
    }
    bool isLastPage = ((state.newsList.count ?? 0) <= (latestNews.length));
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

  void bookMarkLoaded(BuildContext context, BookMarkLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
    });

    if (storeModel != null) {
      latestNews.map((e) {
        if (e.id == storeModel!.id) {
          e.isLiked = ((e.isLiked ?? 1) == 1) ? 0 : 1;
        }
      }).toList();
    }

    callInitialCategory(context);
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
              .then((value) => initApi(context));
        });
      } else if (state.details.statusCode == 500) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
              .then((value) => initApi(context));
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.details.message ?? ""));
        });
      }
    }
  }

  void reportReasonLoaded(BuildContext context, ReportReasonLoaded state) {
    reasonsModel = state.detail.reasons??[];
    callInitialCategory(context);
  }
  void postReportReasonLoaded(BuildContext context, PostReportReasonLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(
          context, AppConstant.errorMessage(state.message));
    });
    callInitialCategory(context);
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
  void microPhonePermissionAskPopUp(BuildContext context, Function onAllow) {
    AllPopUi.warning(
        context: context,
        title: "Turn On Microphone",
        subTitle:"Please Allow Microphone Permission",
        onPressed: (bool value) {
          Navigator.pop(context);
          onAllow();
        });
  }
}
