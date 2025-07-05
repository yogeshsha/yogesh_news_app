import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/data/category_data/domain/report_reason_model.dart';
import 'package:newsapp/presentation/widgets/refresh_widget.dart';
import 'package:newsapp/utils/date_formatter.dart';
import '../../../constants/app_constant.dart';
import '../../../data/category_data/category_bloc/category_bloc.dart';
import '../../../data/category_data/domain/category_model/all_news_model.dart';
import '../../../data/category_data/domain/category_model/news_category_model.dart';
import '../../../utils/app.dart';
import '../../widgets/loader.dart';
import '../news_details/your_news_function.dart';
import 'component/category_component.dart';
import 'component/featured_news_component.dart';
import 'component/news_list_component.dart';

class HomeScreen extends StatefulWidget {
  final bool currentScreen;

  const HomeScreen({super.key, required this.currentScreen});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class NewsTab {
  final String name;
  final String imageUrl;
  final Widget widget;

  NewsTab({required this.name, required this.widget, required this.imageUrl});
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {


  bool isLoading = false;
  bool checkError = true;
  AllNewsModel? storeModel;
  List<Reasons> reasonsModel = [];

  List<NewsCategoryModel> categoryList = [];
  List<int> selectedCategoryList = [-1];
  List<AllNewsModel> featuredNews = [];
  List<AllNewsModel> latestNews = [];

  double height = 50;

  ScrollController scrollController = ScrollController();
  int page = 1;
  int limit = AppConstant.paginationLimit;

  @override
  void initState() {
    initApi(context);
    super.initState();
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
      callGetNewsApi(context, pageValue: page + 1, isLoading: false);
    }
  }

  void callInitialCategory(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchInitialCategory());
  }

  void callGetCategoryList(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchCategoryEvent());
  }

  void callGetNewsApi(BuildContext context,
      {int pageValue = 1, bool isLoading = true}) {
    String url = "";
    url = "page=$pageValue&limit=$limit";

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

  void callGetCategory(BuildContext context){
    String url = "?date=${DateFormatter.getDateFormatter6(DateTime.now())}";
    context.read<CategoryBloc>().add(FetchFeaturedNewsEvent(url: url));
  }

  void initApi(BuildContext context) {
    callGetReportReason(context);
  }

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
      if (widget.currentScreen) {
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
        } else if (state is FeaturedNewsLoaded) {
          featuredNewsLoaded(context, state);
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
                  child: RefreshComponent(
                    scrollController: scrollController,
                    onRefresh: () {
                      initApi(context);
                    },
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                            child: FeaturedNewsComponent(
                              onTap: (AllNewsModel model){
                                Map map = {'id': model.id};
                                Navigator.pushNamed(
                                    context, "/searchDetailScreen",
                                    arguments: map);
                              },
                                featuredNews: featuredNews,
                                onTapIsBookMark:
                                    (AllNewsModel model, bool value) {
                                  callLikedApi(context, model, value);
                                })),
                        SliverAppBar(
                          pinned: true,
                          floating: true,
                          backgroundColor: Theme.of(context).primaryColor,
                          surfaceTintColor: Theme.of(context).primaryColor,
                          leadingWidth: 0,
                          centerTitle: false,
                          leading: const SizedBox(),
                          title: CategoryComponent(
                              categoryList: categoryList,
                              selectedCategoryList: selectedCategoryList,
                              onRemoveList: (int id) {
                                latestNews.clear();
                                selectedCategoryList.remove(id);
                                if (selectedCategoryList.isEmpty) {
                                  selectedCategoryList.add(-1);
                                }
                                callGetNewsApi(context);
                              },
                              onAddCategory: (int id) {
                                latestNews.clear();
                                selectedCategoryList.remove(-1);
                                selectedCategoryList.add(id);
                                callGetNewsApi(context);
                              },
                              onTapAll: () {
                                latestNews.clear();
                                selectedCategoryList.clear();
                                selectedCategoryList.add(-1);
                                callGetNewsApi(context);
                              }),
                        ),

                        SliverToBoxAdapter(
                          child: NewsListComponent(
                              onTapList: (AllNewsModel model) {
                                Map map = {'id': model.id};
                                Navigator.pushNamed(
                                    context, "/searchDetailScreen",
                                    arguments: map);
                              },
                              newsList: latestNews,
                              onTapReport: (int newsId){
                                if(reasonsModel.isNotEmpty) {
                                  YourNewsFunction.showReportBottomSheet(context,reasonsModel,
                                    (reason){
                                    callPostReportReason(context,newsId,reason);
                                    },);
                                }
                              },
                              onTapIsBookMark:(AllNewsModel model, bool value) {
                                callLikedApi(context, model, value);
                              },
                              scrollController: scrollController),
                        )
                      ],
                    ),
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
    callGetNewsApi(context);
  }

  void bookMarkLoaded(BuildContext context, BookMarkLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
    });

    if (storeModel != null) {
      featuredNews.map((e) {
        if (e.id == storeModel!.id) {
          e.isLiked = ((e.isLiked ?? 1) == 1) ? 0 : 1;
        }
      }).toList();
      latestNews.map((e) {
        if (e.id == storeModel!.id) {
          e.isLiked = ((e.isLiked ?? 1) == 1) ? 0 : 1;
        }
      }).toList();
    }

    callInitialCategory(context);
  }

  void featuredNewsLoaded(BuildContext context, FeaturedNewsLoaded state) {
    featuredNews = [...state.featuredNews];
    callGetCategoryList(context);
  }

  void allNewsLoaded(BuildContext context, AllNewsLoaded state) {

    if(state.newsList.imageUrl != null){

    }
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
    callInitialCategory(context);
    // latestNews.map((e) => featuredNews.add(AllNewsModel.fromJson(e.toJson()))).toList();
    // callGetReportReason(context);
  }

  void reportReasonLoaded(BuildContext context, ReportReasonLoaded state) {
    reasonsModel = state.detail.reasons??[];
    callGetCategory(context);
  }
  void postReportReasonLoaded(BuildContext context, PostReportReasonLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(
          context, AppConstant.errorMessage(state.message));
    });
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

}
