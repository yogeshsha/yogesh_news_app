import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/data/subscription_data/domain/subscription_model/subscription_models.dart';
import 'package:newsapp/presentation/screens/my_subscription/component/expanded_plan_container.dart';
import 'package:newsapp/presentation/widgets/dot_component.dart';
import 'package:newsapp/presentation/widgets/ink_well_custom.dart';
import 'package:newsapp/presentation/widgets/loader.dart';
import 'package:newsapp/presentation/widgets/not_found_common.dart';
import 'package:newsapp/presentation/widgets/refresh_widget.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import 'package:newsapp/utils/app.dart';
import '../../../constants/app_constant.dart';
import '../../../data/subscription_data/subscription_bloc/subscription_bloc.dart';
import '../../widgets/dotted_line_component.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isLoading = false;
  bool checkError = true;
  int page = 1;
  int limit = AppConstant.paginationLimit;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<SubscriptionListModel> subscriptionModel = [];
  bool currentScreen = true;

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getAllSubscriptionApi(context,
          pageValue: page + 1, isScroll: true, isLoading: false);
    }
  }

  void addServiceListener() {
    scrollController.addListener(_scrollListener);
  }

  void removeServiceListener() {
    scrollController.removeListener(_scrollListener);
  }

  @override
  void initState() {
    getAllSubscriptionApi(context);
    super.initState();
  }

  void callAddFreeSubscription(BuildContext context) {

    context.read<SubscriptionBloc>().add(const AddFreeSubscriptionEvent());
  }

  void callInitialSubscription(BuildContext context) {
    context.read<SubscriptionBloc>().add(const FetchInitialSubscription());
  }

  void callAddSubscription(BuildContext context, int id) {
    Map map = {"subscriptionPlanId": id};
    context.read<SubscriptionBloc>().add(FetchAddSubscription(body: map));
  }

  void getAllSubscriptionApi(BuildContext context,
      {int pageValue = 1, bool isScroll = false, bool isLoading = true}) {
    String url = "";
    url = "?page=$pageValue&limit=$limit";
    page = pageValue;
    context
        .read<SubscriptionBloc>()
        .add(GetAllSubscriptionEvent(url: url, isLoading: isLoading));
  }

  void navigateToHome(BuildContext context){
    SessionHelper().put(SessionHelper.profileStatus, "2");
    Navigator.pushNamedAndRemoveUntil(
        context, "/home", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
      if (currentScreen) {
        if (state is SubscriptionLoading) {
          isLoading = true;
          checkError = true;
        } else if (state is SubscriptionInitial) {
          isLoading = false;
          checkError = true;
        } else if (state is SubscriptionError) {
          subscriptionError(context, state);
        } else if (state is OtherSubscriptionLoaded) {
          otherSubscriptionLoaded(context, state);
        } else if (state is SubscriptionLoaded) {
          subscriptionLoaded(context, state);
        } else if (state is AddSubscriptionLoaded) {
          addSubscriptionLoaded(context, state);
        }else if (state is AddFreeSubscriptionLoaded) {
          addFreeSubscriptionLoaded(context, state);
        }
      }
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Stack(
            children: [
              SvgPicture.asset(ImagesConstants.appImageOne),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: mediaHeight,
                width: mediaWidth,
                child: RefreshComponent(
                  scrollController: scrollController,
                  onRefresh: () {
                    getAllSubscriptionApi(context);
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
                              callAddFreeSubscription(context);
                              // Navigator.pushNamed(context, "/home");
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
                                        color: ColorsConstants.textGrayColor,
                                        max: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: mediaHeight * .04),
                        SimpleText(
                            alignment: TextAlign.center,
                            text: "Choose your Plan!",
                            style: GoogleFonts.crimsonText(
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                                color: Theme.of(context).colorScheme.primary)),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 10),
                          child: SimpleText(
                            alignment: TextAlign.center,
                            text: "Unlock exclusive perks, just for you.",
                            size: 14,
                            color: ColorsConstants.textGrayColor,
                          ),
                        ),
                        const SizedBox(height: 30),
                        subscriptionModel.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: subscriptionModel.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  SubscriptionListModel list =
                                      subscriptionModel[index];
                                  double percentage = 0;
                                  String planName = list.name ?? "";
                                  String description = list.description ?? "";
                                  String amount =
                                      (list.price ?? 0).toStringAsFixed(2);
                                  int id = list.id ?? 0;
                                  percentage = ((list.discountedPrice ?? 0) /
                                          (list.price ?? 0)) *
                                      100;
                                  ExpandableController controller =
                                      list.controller;
                                  bool showLoader = (index ==
                                          ((subscriptionModel.length) - 1)) &&
                                      scrollController.hasListeners;
                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        decoration: BoxDecoration(
                                            color: controller.value
                                                ? ColorsConstants.appColor
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: controller.value
                                                    ? ColorsConstants.appColor
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onSurface)),
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: ExpandablePanel(
                                            controller: controller,
                                            collapsed: ExpandedPlanContainer(
                                              checkToChangeColor: true,
                                              controller: controller,
                                              planTitle: planName,
                                              description: description,
                                              planOffer:
                                                  "${percentage.toStringAsFixed(0)}% ${AppHelper.getDynamicString(context, "OFF")}",
                                              planAmount: "\$$amount",
                                              check: true,
                                              onGetStart: () {
                                                callAddSubscription(
                                                    context, id);
                                                // Map map ={
                                                //   'planName':planName,
                                                //   'description':description,
                                                //   'amount':"\$$amount",
                                                //   'percentage':"${percentage.toStringAsFixed(0)}% OFF"
                                                // };
                                                // Navigator.pushNamed(context, "/selectedSubscriptionScreen",arguments: map);
                                              },
                                              openDetail: (value) {
                                                controller.value = value;
                                                setState(() {});
                                              },
                                            ),
                                            expanded: Column(
                                              children: [
                                                ExpandedPlanContainer(
                                                  checkToChangeColor: true,
                                                  controller: controller,
                                                  planTitle: planName,
                                                  description: description,
                                                  planOffer:
                                                      "${percentage.toStringAsFixed(0)}% ${AppHelper.getDynamicString(context, "OFF")}",
                                                  planAmount: "\$$amount",
                                                  check: false,
                                                  onGetStart: () {
                                                    callAddSubscription(
                                                        context, id);
                                                  },
                                                  openDetail: (value) {
                                                    controller.value = value;
                                                    setState(() {});
                                                  },
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 20.0),
                                                  child:
                                                      DottedAxisLineComponent(
                                                          color: ColorsConstants
                                                              .white,
                                                          axis: Axis.horizontal,
                                                          length:
                                                              mediaWidth * .90,
                                                          dashLength: 5),
                                                ),
                                                if (list.shortDescription !=
                                                    null)
                                                  ListView.builder(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      shrinkWrap: true,
                                                      itemCount: list
                                                          .shortDescription!
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        String shortList =
                                                            list.shortDescription![
                                                                index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 7.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              DotComponent(
                                                                color:
                                                                    ColorsConstants
                                                                        .white,
                                                                size: 8,
                                                              ),
                                                              const SizedBox(
                                                                  width: 15),
                                                              Expanded(
                                                                child: TextAll(
                                                                    align: TextAlign
                                                                        .start,
                                                                    text:
                                                                        shortList,
                                                                    weight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: ColorsConstants
                                                                        .white,
                                                                    max: 11),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                              ],
                                            )),
                                      ),
                                      if (showLoader)
                                        Center(
                                          child: CircularProgressIndicator(
                                              color: ColorsConstants.appColor),
                                        ),
                                    ],
                                  );
                                })
                            : const NotFoundCommon(
                                showButton: false,
                              ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading) const Loading(),
            ],
          ),
        ),
      );
    });
  }

  void subscriptionError(BuildContext context, SubscriptionError state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        callInitialSubscription(context);
        String errorMessage = AppConstant.errorMessage(state.message);
        if (AppConstant.checkConnectionTimeOut(errorMessage)) {
          Navigator.pushNamed(context, "/connectionTimeout")
              .then((value) => getAllSubscriptionApi(context));
        } else {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.message));
        }
      });
    }
  }

  void addFreeSubscriptionLoaded(BuildContext context, AddFreeSubscriptionLoaded state) {

    callInitialSubscription(context);
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(context, state.message);
        navigateToHome(context);
      });

    }
  }

  void otherSubscriptionLoaded(
      BuildContext context, OtherSubscriptionLoaded state) {
    callInitialSubscription(context);

    if (state.details.statusCode == 401 || state.details.statusCode == 403) {
      callInitialSubscription(context);
      Map map = {};
      map['check'] = true;
      map['hideSocialLogin'] = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (checkError) {
          checkError = false;
          Navigator.pushNamed(context, "/sessionExpired")
              .then((value) => getAllSubscriptionApi(context));
        }
      });
    } else if (state.details.statusCode == 500) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
            .then((value) => getAllSubscriptionApi(context));
      });
    } else {
      callInitialSubscription(context);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(
            context, AppConstant.errorMessage(state.details.message ?? ""));
      });
    }
  }

  void subscriptionLoaded(BuildContext context, SubscriptionLoaded state) {
    AppHelper.myPrint("-----------SubscriptionLoaded----------");
    callInitialSubscription(context);
    if (page == 1 || page == 0) {
      subscriptionModel = state.details.subscriptionList ?? [];
    } else {
      state.details.subscriptionList!
          .map((e) => subscriptionModel.add(e))
          .toList();
    }
    bool isLastPage = (state.details.count ?? 0) <= subscriptionModel.length;

    if (isLastPage) {
      if (scrollController.hasListeners) {
        removeServiceListener();
      }
    } else {
      if (!scrollController.hasListeners) {
        addServiceListener();
      }
    }
  }

  void addSubscriptionLoaded(
      BuildContext context, AddSubscriptionLoaded state) {
    if(checkError){
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        callInitialSubscription(context);
        AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
        navigateToHome(context);
      });
    }

  }
}
