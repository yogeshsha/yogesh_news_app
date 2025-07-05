import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/presentation/screens/setting/component/common_app_bar_component.dart';
import 'package:newsapp/presentation/widgets/not_found_common.dart';
import 'package:newsapp/presentation/widgets/refresh_widget.dart';
import '../../../constants/app_constant.dart';
import '../../../data/category_data/category_bloc/category_bloc.dart';
import '../../../data/category_data/domain/category_model/all_news_model.dart';
import '../../../data/category_data/domain/category_model/news_category_model.dart';
import '../../../utils/app.dart';
import '../../widgets/floating_button.dart';
import '../../widgets/loader.dart';
import '../home/component/category_component.dart';
import '../home/component/news_list_component.dart';

class YourNewsScreen extends StatefulWidget {

  const YourNewsScreen({super.key});

  @override
  State<YourNewsScreen> createState() => YourNewsScreenState();
}

class NewsTab {
  final String name;
  final String imageUrl;
  final Widget widget;

  NewsTab({required this.name, required this.widget, required this.imageUrl});
}

class YourNewsScreenState extends State<YourNewsScreen>
    with TickerProviderStateMixin {
  bool isLoading = false;
  bool checkError = true;
  AllNewsModel? storeModel;
  List<NewsCategoryModel> categoryList = [];
  List<int> selectedCategoryList = [-1];
  List<AllNewsModel> yourNewsListModel = [];
  double height = 50;
  ScrollController scrollController = ScrollController();
  int page = 1;
  int limit = AppConstant.paginationLimit;
  bool currentScreen = true;

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
      AppHelper.navigateToRegister(context: context, onUserFound: () {
        callLikedApi(context, model, value);
      });
    }
  }

  void initApi(BuildContext context) {
    if (AppHelper.checkUser()) {
      callGetCategoryList(context);
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
      callGetYourNewsApi(context, pageValue: page + 1, isLoading: false);
    }
  }

  void callInitialCategory(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchInitialCategory());
  }

  void callGetCategoryList(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchCategoryEvent());
  }

  void callDeleteNews(BuildContext context, int id) {
    context.read<CategoryBloc>().add(FetchDeleteNewsEvent(id: id));
  }

  void callGetYourNewsApi(BuildContext context,
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
    context.read<CategoryBloc>().add(
        FetchYourNewsEvent(isLoading: isLoading, url: url));
  }


  void navigateAdd(BuildContext context) {
    Map map = {
      'categoryList': categoryList,
      'newsId': 0,
    };
    currentScreen = false;
    Navigator.pushNamed(context, "/uploadNewsScreen", arguments: map).then((
        value) {
      yourNewsListModel.clear();
      callGetYourNewsApi(context);
      currentScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        } else if (state is NewsCategoryLoaded) {
          categoryLoaded(context, state);
        } else if (state is OtherStatusCodeCategoryLoaded) {
          otherStatusCodeCategory(context, state);
        } else if (state is AllYourNewsLoaded) {
          allYourNewsLoaded(context, state);
        } else if (state is BookMarkLoaded) {
          bookMarkLoaded(context, state);
        } else if (state is DeleteNewsLoaded) {
          deleteNewsLoaded(context, state);
        }
      }
      return Stack(
        children: [
          Scaffold(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            body: SafeArea(
              child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      const CommonAppBarComponent(
                        title: "Your News",
                        showBookMark: false
                      ),
                      CategoryComponent(
                        margin: EdgeInsets.symmetric(vertical: categoryList.isEmpty? 0 : 10),
                          categoryList: categoryList,
                          selectedCategoryList: selectedCategoryList,
                          onRemoveList: (int id) {
                            yourNewsListModel.clear();
                            selectedCategoryList.remove(id);
                            if (selectedCategoryList.isEmpty) {
                              selectedCategoryList.add(-1);
                            }
                            callGetYourNewsApi(context);
                          },
                          onAddCategory: (int id) {
                            yourNewsListModel.clear();
                            selectedCategoryList.remove(-1);
                            selectedCategoryList.add(id);
                            callGetYourNewsApi(context);
                          },
                          onTapAll: () {
                            yourNewsListModel.clear();
                            selectedCategoryList.clear();
                            selectedCategoryList.add(-1);
                            callGetYourNewsApi(context);
                          }),
                      Expanded(
                          child: AppHelper.checkUser()
                              ? RefreshComponent(
                              scrollController: scrollController,
                              onRefresh: () {
                                initApi(context);
                              },
                              child: SingleChildScrollView(
                                primary: false,
                                physics: const BouncingScrollPhysics(),
                                child: NewsListComponent(
                                  dropDownTitle: "Option",
                                  scrollController: scrollController,
                                  showDeleteOnly: true,
                                  onTapList: (AllNewsModel model) {
                                    Map map = {
                                      'id': model.id
                                    };
                                    Navigator.pushNamed(
                                        context, "/newsDetails",
                                        arguments: map);
                                  },
                                  newsList: yourNewsListModel,
                                  onTapDelete: (id, value) {
                                    if (value == "delete") {
                                      callDeleteNews(context, id);
                                    } else if (value == "edit") {
                                      Map map = {
                                        'newsId': id,
                                        'categoryList': categoryList,
                                      };
                                      currentScreen = false;
                                      Navigator.pushNamed(
                                          context, "/uploadNewsScreen",
                                          arguments: map).then((value) {
                                        yourNewsListModel.clear();
                                        callGetYourNewsApi(context);
                                        currentScreen = true;
                                      });
                                    }
                                  },
                                  onTapReport: (newsId){
                                  },
                                  onTapIsBookMark: (AllNewsModel model,
                                      bool value) {},
                                ),
                              )

                          ) : Center(
                            child: NotFoundCommon(
                                subTitle: "Log in to see bookmark",
                                buttonFullTitle: "Log in",
                                onTap: () {
                                  AppHelper.navigateToRegister(
                                      context: context,
                                      onUserFound: () {
                                        initApi(context);
                                      });
                                }),
                          ),
                      )
                    ],
                  )),
            ),
          ),
          if(AppHelper.checkUser())
          FloatingButtonWidget(
              onTap: () {
                currentScreen = false;
                navigateAdd(context);
              }),
          if (isLoading) const Loading()
        ],
      );
    });
  }


  void categoryLoaded(BuildContext context, NewsCategoryLoaded state) {
    categoryList = state.category;
    categoryList.insert(0, NewsCategoryModel(name: "All", id: -1));
    callGetYourNewsApi(context);
  }

  void bookMarkLoaded(BuildContext context, BookMarkLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
    });

    if (storeModel != null) {
      yourNewsListModel.map((e) {
        if (e.id == storeModel!.id) {
          e.isLiked = ((e.isLiked ?? 1) == 1) ? 0 : 1;
        }
      }).toList();
    }

    callInitialCategory(context);
  }

  void deleteNewsLoaded(BuildContext context, DeleteNewsLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
    });
    callInitialCategory(context);
  }

  void allYourNewsLoaded(BuildContext context, AllYourNewsLoaded state) {
    if (page == 1 || page == 0) {
      yourNewsListModel = [];

      (state.yourNews.yourNewsListModel ?? []).map((e) {
        yourNewsListModel.add(e);
      }).toList();
    } else {
      (state.yourNews.yourNewsListModel ?? []).map((e) {
        yourNewsListModel.add(e);
      }).toList();
    }
    bool isLastPage = ((state.yourNews.count ?? 0) <=
        (yourNewsListModel.length));
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
  }

  void otherStatusCodeCategory(BuildContext context,
      OtherStatusCodeCategoryLoaded state) {
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
      }else if (state.details.statusCode == 500) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
              .then((value) => initApi(context));
        });
      }  else {
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
