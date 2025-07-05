import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/data/subscription_data/domain/subscription_model/current_subscription_model.dart';
import 'package:newsapp/presentation/widgets/loader.dart';
import 'package:newsapp/presentation/widgets/refresh_widget.dart';

import '../../../constants/app_constant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/common_model/text_span_model.dart';
import '../../../data/subscription_data/domain/subscription_model/subscription_models.dart';
import '../../../data/subscription_data/subscription_bloc/subscription_bloc.dart';
import '../../../utils/app.dart';
import '../../widgets/dot_component.dart';
import '../../widgets/dotted_line_component.dart';
import '../../widgets/primary_button_component.dart';
import '../../widgets/rich_text.dart';
import '../../widgets/text_common.dart';
import '../setting/component/common_app_bar_component.dart';
import 'component/expanded_plan_container.dart';

class ManageSubscriptionScreen extends StatefulWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  State<ManageSubscriptionScreen> createState() =>
      _ManageSubscriptionScreenState();
}

class _ManageSubscriptionScreenState extends State<ManageSubscriptionScreen> {
  bool currentScreen = true;
  bool isLoading = false;
  bool checkError = true;
  CurrentSubscription? currentPlanModel;
  List<SubscriptionListModel> upgradeList = [];

  bool isActivePlan = true;

  @override
  void initState() {
    callGetMySubscription(context);
    super.initState();
  }

  void callInitialSubscription(BuildContext context) {
    context.read<SubscriptionBloc>().add(const FetchInitialSubscription());
  }

  void callGetMySubscription(BuildContext context) {
    context.read<SubscriptionBloc>().add(const GetCurrentSubscription());
  }

  void callRenewSubscription(BuildContext context, int id) {
    Map map = {"subscriptionId": id};
    context.read<SubscriptionBloc>().add(RenewSubscription(body: map));
  }

  void callUpgradePlan(BuildContext context, SubscriptionListModel model) {
    Map map = {"subscriptionPlanId": model.id};
    context.read<SubscriptionBloc>().add(UpgradeSubscription(body: map));
  }

  void callBuyPlan(BuildContext context, SubscriptionListModel model) {
    Map map = {"subscriptionPlanId": model.id};
    context.read<SubscriptionBloc>().add(FetchAddSubscription(body: map));
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
        } else if (state is CurrentSubscriptionLoaded) {
          currentSubscriptionLoaded(context, state);
        } else if (state is RenewSubscriptionLoaded) {
          renewSubscriptionLoaded(context, state);
        } else if (state is AddSubscriptionLoaded) {
          addSubscriptionLoaded(context, state);
        }else if (state is UpgradeSubscriptionLoaded) {
          upgradeSubscriptionLoaded(context, state);
        }
      }
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: SizedBox(
          height: mediaHeight,
          width: mediaWidth,
          child: Stack(
            children: [
              Column(
                children: [
                  const CommonAppBarComponent(
                    title: "Subscription",
                  ),
                  SizedBox(
                    height: mediaHeight * .03,
                  ),
                  Expanded(
                    child: RefreshComponent(
                      onRefresh: () {
                        callGetMySubscription(context);
                      },
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            if (currentPlanModel != null &&
                                currentPlanModel!.subscriptionPlan != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: ColorsConstants.appColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: ColorsConstants
                                            .textGrayColorLightThree)),
                                margin: const EdgeInsets.only(
                                    bottom: 10, left: 15, right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: TextAll(
                                                align: TextAlign.start,
                                                text: currentPlanModel!
                                                        .subscriptionPlan!
                                                        .name ??
                                                    "",
                                                weight: FontWeight.w500,
                                                color: ColorsConstants.white,
                                                max: 14)),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: ColorsConstants.white,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 0),
                                              child: TextAll(
                                                  text: isActivePlan
                                                      ? "Active"
                                                      : "Expire",
                                                  weight: FontWeight.w500,
                                                  color:
                                                      ColorsConstants.appColor,
                                                  max: 14),
                                            ))
                                      ],
                                    ),
                                    RichTextComponent2(list: [
                                      TextSpanModel(
                                          title: (currentPlanModel!
                                                      .subscriptionPlan!
                                                      .price ??
                                                  0)
                                              .toStringAsFixed(2),
                                          style: GoogleFonts.crimsonText(
                                              color: ColorsConstants.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 40)),
                                      TextSpanModel(
                                          title: "/Month",
                                          style: GoogleFonts.crimsonText(
                                              color: ColorsConstants.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20))
                                    ]),
                                    RichTextComponent2(list: [
                                      TextSpanModel(
                                          title: currentPlanModel!
                                                  .subscriptionPlan!
                                                  .description ??
                                              "",
                                          style: GoogleFonts.poppins(
                                              color: ColorsConstants.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12)),
                                    ]),
                                    if (!isActivePlan)
                                      PrimaryButtonComponent(
                                          allowBorder: true,
                                          borderColor: ColorsConstants.white,
                                          textColor: ColorsConstants.white,
                                          margin: const EdgeInsets.only(
                                              top: 15, bottom: 10),
                                          title: "Renew Subscription",
                                          onTap: () {
                                            callRenewSubscription(context,
                                                currentPlanModel!.id ?? 0);
                                          }),
                                  ],
                                ),
                              ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: ColorsConstants.textGrayColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextAll(
                                        text: "Other Plans",
                                        weight: FontWeight.w400,
                                        color: ColorsConstants.textGrayColor,
                                        max: 14),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: ColorsConstants.textGrayColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (upgradeList.isNotEmpty)
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: upgradeList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    SubscriptionListModel model =
                                        upgradeList[index];
                                    double percentage = 0;
                                    String planName = model.name ?? "";
                                    String description = model.description ?? "";
                                    String amount =
                                        (model.price ?? 0).toStringAsFixed(2);
                                    percentage = ((model.discountedPrice ?? 0) /
                                            (model.price ?? 0)) *
                                        100;
                                    ExpandableController controller =
                                        model.controller;
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: ColorsConstants
                                                  .textGrayColorLightThree)),
                                      margin: const EdgeInsets.only(
                                          bottom: 10, left: 15, right: 15),
                                      child: ExpandablePanel(
                                          controller: controller,
                                          collapsed: ExpandedPlanContainer(
                                            checkToChangeColor: false,
                                            buttonName: isActivePlan
                                                ? "Upgrade Plan"
                                                : "Buy Plan",
                                            controller: controller,
                                            planTitle: planName,
                                            description: description,
                                            planOffer:
                                                "${percentage.toStringAsFixed(0)}% ${AppHelper.getDynamicString(context, "OFF")}",
                                            planAmount: "\$$amount",
                                            check: true,
                                            onGetStart: () {
                                              if(isActivePlan){
                                                callUpgradePlan(context,model);
                                              }else{
                                                callBuyPlan(context,model);
                                              }

                                              // currentScreen = false;
                                              // Navigator.pushNamed(context,
                                              //         "/subscriptionScreen")
                                              //     .then((value) =>
                                              //         currentScreen = true);
                                            },
                                            openDetail: (value) {
                                              controller.value = value;
                                            },
                                          ),
                                          expanded: Column(
                                            children: [
                                              ExpandedPlanContainer(
                                                checkToChangeColor: false,
                                                buttonName: "Buy Plan",
                                                controller: controller,
                                                planTitle: planName,
                                                description: description,
                                                planOffer:
                                                    "${percentage.toStringAsFixed(0)}% ${AppHelper.getDynamicString(context, "OFF")}",
                                                planAmount: "\$$amount",
                                                check: false,
                                                onGetStart: () {
                                                  currentScreen = false;
                                                  Navigator.pushNamed(context,
                                                          "/subscriptionScreen")
                                                      .then((value) =>
                                                          currentScreen = true);
                                                },
                                                openDetail: (value) {
                                                  controller.value = value;
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0),
                                                child: DottedAxisLineComponent(
                                                    color: ColorsConstants
                                                        .textGrayColor,
                                                    axis: Axis.horizontal,
                                                    length: mediaWidth * .90,
                                                    dashLength: 5),
                                              ),
                                              if (model.shortDescription != null)
                                                ListView.builder(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    shrinkWrap: true,
                                                    itemCount: model
                                                        .shortDescription!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      String shortList =
                                                          model.shortDescription![
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
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onTertiaryContainer,
                                                              size: 8,
                                                            ),
                                                            const SizedBox(
                                                                width: 15),
                                                            Expanded(
                                                              child: TextAll(
                                                                  align:
                                                                      TextAlign
                                                                          .start,
                                                                  text:
                                                                      shortList,
                                                                  weight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onTertiaryContainer,
                                                                  max: 11),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                            ],
                                          )),
                                    );
                                  })
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              if (isLoading) const Loading()
            ],
          ),
        )),
      );
    });
  }
  void addSubscriptionLoaded(
      BuildContext context, AddSubscriptionLoaded state) {
    if(checkError){
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        callInitialSubscription(context);
        AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
        callGetMySubscription(context);
      });
    }

  }
  void upgradeSubscriptionLoaded(
      BuildContext context, UpgradeSubscriptionLoaded state) {
    if(checkError){
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        callInitialSubscription(context);
        AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
        callGetMySubscription(context);
      });
    }

  }

  void subscriptionError(BuildContext context, SubscriptionError state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        callInitialSubscription(context);
        String errorMessage = AppConstant.errorMessage(state.message);
        if (AppConstant.checkConnectionTimeOut(errorMessage)) {
          Navigator.pushNamed(context, "/connectionTimeout")
              .then((value) => callGetMySubscription(context));
        } else {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.message));
        }
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
              .then((value) => callGetMySubscription(context));
        }
      });
    } else if (state.details.statusCode == 500) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
            .then((value) => callGetMySubscription(context));
      });
    } else {
      callInitialSubscription(context);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(
            context, AppConstant.errorMessage(state.details.message ?? ""));
      });
    }
  }

  void currentSubscriptionLoaded(
      BuildContext context, CurrentSubscriptionLoaded state) {
    AppHelper.myPrint("-----------CurrentSubscriptionLoaded----------");
    callInitialSubscription(context);
    if (state.details.currentSubscription != null) {
      currentPlanModel = state.details.currentSubscription;
    }
    if (currentPlanModel != null) {
      isActivePlan = (currentPlanModel!.planStatus ?? "") == "active";
    }

    upgradeList = state.details.upgradeTo ?? [];
  }

  void renewSubscriptionLoaded(
      BuildContext context, RenewSubscriptionLoaded state) {
    AppHelper.myPrint("-----------CurrentSubscriptionLoaded----------");
    callInitialSubscription(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(context, AppConstant.errorMessage(state.message));
    });
  }
}
