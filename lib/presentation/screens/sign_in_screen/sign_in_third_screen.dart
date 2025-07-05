import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/presentation/screens/sign_in_screen/component/bottom_button_component.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
import 'package:newsapp/presentation/widgets/loader.dart';
import 'package:newsapp/presentation/widgets/not_found_common.dart';
import 'package:newsapp/presentation/widgets/refresh_widget.dart';
import 'package:newsapp/presentation/widgets/search_component.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import 'package:newsapp/presentation/widgets/tick_box_component.dart';
import 'package:newsapp/utils/app.dart';
import 'package:newsapp/utils/image_builder.dart';
import '../../../constants/app_constant.dart';
import '../../../data/category_data/category_bloc/category_bloc.dart';
import '../../../data/category_data/domain/category_model/news_category_model.dart';
import '../../widgets/text_form_field.dart';
import '../popups/pop_ups_screen.dart';

class SignInThirdScreen extends StatefulWidget {
  const SignInThirdScreen({super.key});

  @override
  State<SignInThirdScreen> createState() => _SignInThirdScreenState();
}

class _SignInThirdScreenState extends State<SignInThirdScreen> {
  bool isLoading = false;
  bool checkError = true;
  TextEditingController searchController = TextEditingController();
  List<NewsCategoryModel> categoryList = [];
  List<NewsCategoryModel> selectedCategoryList = [];

  Future<bool> onWillPop() async {
    warningExitApp(context);
    return false;
  }

  void warningExitApp(BuildContext context) {
    AllPopUi.warning(
        context: context,
        title: "Are You Sure",
        subTitle: "You want to exit this app",
        onPressed: (bool value) {
          exit(0);
        });
  }

  void callInitialCategory(BuildContext context) {
    context.read<CategoryBloc>().add(const FetchInitialCategory());
  }

  void callGetCategoryList(BuildContext context, {bool isLoading = true}) {
    String url = "";
    if (searchController.text.trim().isNotEmpty) {
      url = "?search=${searchController.text.trim()}";
    }
    context
        .read<CategoryBloc>()
        .add(FetchCategoryEvent(url: url, isLoading: isLoading));
  }

  void callAddCategory(BuildContext context) {
    Map body = {};

    List<int> categoryId = [];
    bool check = false;
    selectedCategoryList.map((e) {
      if (e.id == -1) {
        check = true;
      } else {
        categoryId.add(e.id ?? 0);
      }
    }).toList();

    if (check) {
      categoryId.clear();
      categoryList.map((e) {
        if ((e.id ?? 0) > 0) {
          categoryId.add(e.id ?? 0);
        }
      }).toList();
    }

    if (categoryId.isNotEmpty) {
      body["interests"] = categoryId;
    }
    body["profileStatus"] =1;

    context.read<CategoryBloc>().add(AddCategoryEvent(body: body));
  }
  void callUpdateProfileStatus(BuildContext context) {
    Map body = {
      "profileStatus":1
    };


    context.read<CategoryBloc>().add(UpdateMyDetailsEvent(body: body));
  }

  @override
  void initState() {
    callGetCategoryList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
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
      } else if (state is AddCategoryLoaded) {
        addCategoryLoaded(context, state);
      } else if (state is UpdateUserLoaded) {
        updateUserLoaded(context, state);
      }
      return WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              body: SafeArea(
                child: Stack(
                  children: [
                    SvgPicture.asset(ImagesConstants.appImageOne),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: mediaHeight,
                      width: mediaWidth,
                      child: RefreshComponent(
                        onRefresh: () {
                          callGetCategoryList(context);
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: InkWellCustom(
                                  onTap: () {
                                    callUpdateProfileStatus(context);
                                  },
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      SizedBox(
                                        height: 25,
                                        child: Center(
                                          child: TextAll(
                                              text: "Skip for now",
                                              weight: FontWeight.w600,
                                              color:
                                                  ColorsConstants.textGrayColor,
                                              max: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: mediaHeight * .06),
                              const SimpleText(
                                  alignment: TextAlign.center,
                                  text: "What’s your Interests?",
                                  weight: FontWeight.w700,
                                  size: 28),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 50, right: 50, bottom: 10),
                                child: SimpleText(
                                  alignment: TextAlign.center,
                                  text:
                                      "Headlines that matter, at your fingertips.",
                                  size: 14,
                                ),
                              ),
                              SearchComponent(
                                  curve: 10,
                                  searchController: searchController,
                                  callApi: () {
                                    callGetCategoryList(context,
                                        isLoading: false);
                                  }),
                              const SizedBox(height: 20),
                              categoryList.isNotEmpty
                                  ? SizedBox(
                                      width: mediaWidth,
                                      child: Wrap(
                                        spacing: 20,
                                        runSpacing: 20,
                                        children: categoryList.map((e) {
                                          bool isSelected = false;
                                          int id = e.id ?? 0;
                                          String name =
                                              AppHelper.getHindiEnglishText(
                                                  e.name, e.hindiName);
                                          String image = e.image ?? "";

                                          for (int i = 0;
                                              i < selectedCategoryList.length;
                                              i++) {
                                            if (e.id ==
                                                selectedCategoryList[i].id) {
                                              isSelected = true;
                                              break;
                                            }
                                          }

                                          return InkWellCustom(
                                            onTap: () {
                                              if (isSelected) {
                                                selectedCategoryList.remove(e);
                                              } else {
                                                if (id == -1) {
                                                  selectedCategoryList = [
                                                    NewsCategoryModel(
                                                        name: "All", id: -1)
                                                  ];
                                                } else {
                                                  selectedCategoryList
                                                      .removeWhere((element) =>
                                                          element.id == -1);
                                                  selectedCategoryList.add(e);
                                                }
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: mediaWidth * .40,
                                              width: mediaWidth * .40,
                                              decoration: BoxDecoration(
                                                  color: ColorsConstants
                                                      .textGrayColorLightTwo,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Stack(
                                                children: [
                                                  ImageBuilder
                                                      .imageBuilderWithoutContainer(
                                                      height: mediaWidth * .40,
                                                      width: mediaWidth * .40,
                                                          image,
                                                          curve: 10),
                                                  Positioned(
                                                      top: 10,
                                                      right: 10,
                                                      child: TickBox(
                                                        isTicked: isSelected,
                                                        onTap: (bool value) {
                                                          if (isSelected) {
                                                            selectedCategoryList
                                                                .remove(e);
                                                          } else {
                                                            if (id == -1) {
                                                              selectedCategoryList =
                                                                  [
                                                                NewsCategoryModel(
                                                                    name: "All",
                                                                    id: -1)
                                                              ];
                                                            } else {
                                                              selectedCategoryList
                                                                  .removeWhere(
                                                                      (element) =>
                                                                          element
                                                                              .id ==
                                                                          -1);
                                                              selectedCategoryList
                                                                  .add(e);
                                                            }
                                                          }
                                                          setState(() {});
                                                        },
                                                      )),
                                                  Positioned(
                                                      bottom: 0,
                                                      left: 5,
                                                      right: 5,
                                                      child: SimpleText(
                                                          text: name))
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : const NotFoundCommon(
                                      text: "No Result Found",
                                      showButton: false),
                              const SizedBox(height: 150),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BottomButtonComponent(onTapLeft: () {
                      warningExitApp(context);
                    }, onTapRight: () {
                      if (selectedCategoryList.isEmpty) {
                        AppHelper.showSnakeBar(
                            context, "Select At Least one Interest");
                      } else {
                        callAddCategory(context);
                      }
                    })
                  ],
                ),
              ),
            ),
            if (isLoading) const Loading()
          ],
        ),
      );
    });
  }

  void categoryLoaded(BuildContext context, NewsCategoryLoaded state) {
    categoryList = state.category;
    if (categoryList.isNotEmpty && searchController.text.trim().isEmpty) {
      categoryList.insert(0, NewsCategoryModel(name: "All", id: -1));
    }
    callInitialCategory(context);
  }

  void addCategoryLoaded(BuildContext context, AddCategoryLoaded state) {
    callInitialCategory(context);

    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(context, state.message);
        SessionHelper().put(SessionHelper.profileStatus, "1");
        Navigator.pushNamedAndRemoveUntil(
            context, "/subscriptionScreen", (route) => false);
      });
    }
  }
  void updateUserLoaded(BuildContext context, UpdateUserLoaded state) {
    callInitialCategory(context);
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(context, state.message);
        SessionHelper().put(SessionHelper.profileStatus, "1");
        Navigator.pushNamedAndRemoveUntil(
            context, "/subscriptionScreen", (route) => false);
      });

    }
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
              .then((value) => callGetCategoryList(context));
        });
      }else if (state.details.statusCode == 500) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
              .then((value) => callGetCategoryList(context));
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
