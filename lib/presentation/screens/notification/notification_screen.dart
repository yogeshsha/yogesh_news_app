import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/presentation/screens/setting/component/common_app_bar_component.dart';
import 'package:newsapp/utils/app.dart';
import '../../../constants/app_constant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/images_constants.dart';
import '../../../data/notification_data/domain/notification_model/all_notification_model.dart';
import '../../../data/notification_data/domain/notification_model/notification_type_model.dart';
import '../../../data/notification_data/notification_bloc/notification_bloc.dart';
import '../../../data/notification_data/notification_bloc/notification_event.dart';
import '../../../data/notification_data/notification_bloc/notification_state.dart';

import '../../widgets/ink_well_custom.dart';
import '../../widgets/loader.dart';
import '../../widgets/refresh_widget.dart';
import '../../widgets/text_common.dart';
import '../popups/pop_ups_screen.dart';
import 'component/all_notification_screen.dart';
import 'component/category_component.dart';

class NotificationScreens extends StatefulWidget {
  const NotificationScreens({super.key});

  @override
  State<NotificationScreens> createState() => _NotificationScreensState();
}

class _NotificationScreensState extends State<NotificationScreens>
    with TickerProviderStateMixin {
  bool isLoading = true;
  bool checkError = true;
  String notificationType = "";
  List<NotificationType> notificationCategoryList = [];
  NotificationType? selectedCategory;
  List<AllNotificationModel> allNotificationList = [];

  int page = 1;
  int limit = AppConstant.paginationLimit;
  ScrollController scrollController = ScrollController();
  bool showButton = false;

  void addServiceListener() {
    scrollController.addListener(_scrollListener);
  }

  void removeServiceListener() {
    scrollController.removeListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      callAllNotificationEvent(context, pageValue: page + 1, isLoading: false);
    }
  }

  @override
  void initState() {
    callGetNotificationType(context);

    super.initState();
  }

  void callInitialNotification(BuildContext context) {
    context.read<NotificationBloc>.call().add(const FetchInitialNotification());
  }

  void callClearNotification(BuildContext context, {int? id, int? index}) {
    try {
      Map map = {};
      if (id != null) {
        map["notificationId"] = [id];
      } else {
        if (selectedCategory != null) {
          map["notificationCategoryId"] = [selectedCategory!.id];
        }
      }

      if (map.isNotEmpty) {
        context.read<NotificationBloc>.call()
            .add(DeleteNotificationEvent(body: map, index: index));
      }
    } catch (e) {
      if (context.mounted) {
        AppHelper.showSnakeBar(context, e.toString());
      }
    }
  }

  void callGetNotificationType(BuildContext context) {
    String url = "";

    context.read<NotificationBloc>.call().add(FetchNotificationType(url: url));
  }

  void callAllNotificationEvent(BuildContext context,
      {int pageValue = 1, bool isLoading = true}) {
    if (selectedCategory != null) {
      String url = "${selectedCategory!.id}?page=$pageValue&limit=$limit";

      page = pageValue;
      context.read<NotificationBloc>.call()
          .add(AllNotificationEvent(url: url, isLoading: isLoading));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
      if (state is NotificationLoading) {
        isLoading = true;
        checkError = true;
      } else if (state is NotificationInitial) {
        isLoading = false;
        checkError = true;
      } else if (state is NotificationError) {
        notificationError(context, state);
      } else if (state is OtherStatusCodeNotificationLoaded) {
        otherStatusCodeNotificationLoaded(context, state);
      } else if (state is NotificationTypeLoaded) {
        notificationTypeLoaded(context, state);
      } else if (state is AllNotificationLoaded) {
        allNotificationLoaded(context, state);
      } else if (state is DeleteNotificationLoaded) {
        deleteNotificationLoaded(context, state);
      }

      return Stack(
        children: [
          Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const CommonAppBarComponent(title: "Notifications"),
                    CategoryComponent(
                        notificationCategoryList: notificationCategoryList,
                        selectedCategory: selectedCategory,
                        onTap: (NotificationType value) {
                          selectedCategory = value;
                          callAllNotificationEvent(context);
                        }),
                    Expanded(
                      child: RefreshComponent(
                          onRefresh: () {
                            callGetNotificationType(context);
                          },
                          scrollController: scrollController,
                          child: AllNotificationScreen(
                            onDismissed: (int id, int index) {
                              callClearNotification(context,
                                  id: id, index: index);
                            },
                            allNotificationList: allNotificationList,
                            scrollController: scrollController,
                          )),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endContained,
            floatingActionButton: allNotificationList.isNotEmpty
                ? InkWellCustom(
                    onTap: () {
                      AllPopUi.warning(
                          context: context,
                          title: "Are You Sure",
                          subTitle: "You want to delete all Notification",
                          onPressed: (bool value) {
                            Navigator.pop(context);
                            callClearNotification(context);
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 54,
                            width: 54,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorsConstants.clearAllColor),
                            child: SvgPicture.asset(ImagesConstants.trashSvg,
                                fit: BoxFit.none),
                          ),
                          TextAll(
                              text: "Clear All",
                              weight: FontWeight.w600,
                              color: ColorsConstants.clearAllColor,
                              max: 13)
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          if (isLoading) const Loading()
        ],
      );
    });
  }

  void notificationError(BuildContext context, NotificationError state) {
    if (checkError) {
      checkError = false;
      callInitialNotification(context);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        String errorMessage = AppConstant.errorMessage(state.message);
        if (AppConstant.checkConnectionTimeOut(errorMessage)) {
          Navigator.pushNamed(context, "/connectionTimeout")
              .then((value) => callGetNotificationType(context));
        } else {
          AppHelper.showSnakeBar(context, errorMessage);
        }
      });
    }
  }

  void otherStatusCodeNotificationLoaded(
      BuildContext context, OtherStatusCodeNotificationLoaded state) {
    callInitialNotification(context);
    if (state.details.statusCode == 401 || state.details.statusCode == 403) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (checkError) {
          checkError = false;
          Navigator.pushNamed(context, "/sessionExpired")
              .then((value) => callGetNotificationType(context));
        }
      });
    } else if (state.details.statusCode == 500) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
            .then((value) => callGetNotificationType(context));
      });
    } else {
      if (checkError) {
        checkError = false;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.details.message ?? ""));
        });
      }
    }
  }

  void notificationTypeLoaded(
      BuildContext context, NotificationTypeLoaded state) {
    notificationCategoryList = state.details;
    if (notificationCategoryList.isNotEmpty && selectedCategory == null) {
      selectedCategory = notificationCategoryList.first;
    }
    if(notificationCategoryList.isNotEmpty){
      callAllNotificationEvent(context);

    }else{
      callInitialNotification(context);
    }
  }

  void allNotificationLoaded(
      BuildContext context, AllNotificationLoaded state) {
    if (selectedCategory != null) {
      if ((selectedCategory!.notificationCount ?? 0) > 0) {}
      selectedCategory!.notificationCount = 0;
    }

    final isLastPage = state.notifications.length < limit;
    if (isLastPage) {
      if (scrollController.hasListeners) {
        removeServiceListener();
      }
    } else {
      if (!scrollController.hasListeners) {
        addServiceListener();
      }
    }
    if (page == 1) {
      allNotificationList = state.notifications;
    } else {
      state.notifications.map((e) => allNotificationList.add(e)).toList();
    }
    callInitialNotification(context);
  }

  void deleteNotificationLoaded(
      BuildContext context, DeleteNotificationLoaded state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppHelper.showSnakeBar(context, state.message);
    });

    AppHelper.myPrint("---------------- Index -------------");
    AppHelper.myPrint(state.index);
    AppHelper.myPrint("-----------------------------");

    if (state.index != null) {
      allNotificationList.removeAt(state.index ?? 0);
      if (selectedCategory != null) {
        selectedCategory!.notificationCount =
            (selectedCategory!.notificationCount ?? 1) - 1;
      }
      callInitialNotification(context);
    } else {
      if (selectedCategory != null) {
        selectedCategory!.notificationCount = 0;
      }
      callAllNotificationEvent(context);
    }
  }
}
