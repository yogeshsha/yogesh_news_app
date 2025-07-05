import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/constants/app_constant.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/presentation/screens/account/account_screen.dart';
import 'package:newsapp/presentation/screens/home/home_screen.dart';
import 'package:newsapp/presentation/screens/popups/pop_ups_screen.dart';
import 'package:newsapp/presentation/screens/qr_scanner/qr_scanner.dart';
import 'package:newsapp/presentation/screens/setting/my_settings.dart';
import 'package:newsapp/presentation/widgets/stick_logo.dart';
import 'package:newsapp/utils/app_localization.dart';
import '../../constants/colors_constants.dart';
import '../templates/template_1.dart';
import 'live/live_tv_screen.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({super.key});

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorScreenState();
}

class DrawerTab {
  final String name;
  final IconData icon;
  final Function onTap;

  DrawerTab({required this.name, required this.icon, required this.onTap});
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
int currentIndex = 0;
late TabController controller;

class _BottomNavigatorScreenState extends State<BottomNavigatorScreen>
    with TickerProviderStateMixin {
  List<Widget> _screens = [];
  List<DrawerTab> drawerList = [];
  SessionHelper? sessionHelper;
  AutoSizeGroup autoSizeGroup = AutoSizeGroup();

  bool currentScreen = true;
  List<String> iconList = [
    ImagesConstants.homeSvg,
    ImagesConstants.scanIconSvg,
    ImagesConstants.tvIconSvg,
    ImagesConstants.settingsSvg
  ];

  @override
  void initState() {
    initSession();
    controller = TabController(length: 3, vsync: this);
    setScreen(context);
    super.initState();
  }

  void setScreen(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      drawerList = [
        DrawerTab(
            name: AppLocalizations.of(context)!.translate('Home'),
            icon: Icons.home_outlined,
            onTap: () async {
              Navigator.pop(context);
            }),
      ];
      _screens = [
        HomeScreen(currentScreen: currentScreen),
        QRScannerWidget(
          navigateToHome: () {
            currentIndex = 0;
            setScreen(context);
          },
        ),
        // BookmarkScreen(
        //     navigateToHome: () {
        //       currentIndex = 0;
        //       setScreen(context);
        //     },
        //     currentScreen: currentScreen),
        LiveTvScreen(navigateToHome: () {
          currentIndex = 0;
          setScreen(context);
        }),

        // Account(navigateToHome: () {
        //   currentIndex = 0;
        //   setScreen(context);
        // }),
        // DetailStoriesScreen(id: "1"),
        MySettings(navigateToHome: () {
          currentIndex = 0;
          setScreen(context);
        }),
      ];
      setState(() {});
    });
  }

  void initSession() {
    SessionHelper().put(SessionHelper.isShowAds, "true");
  }

  bool before() {
    bool check = true;
    if (controller.index == 1) {
      if (LiveTvScreenState.videoPlayerController != null) {
        check = LiveTvScreenState.videoPlayerController!.value.isPlaying;
        LiveTvScreenState.videoPlayerController!.pause();
      }
    } else if (controller.index == 0) {
      if (Template1State.videoPlayerController != null) {
        check = Template1State.videoPlayerController!.value.isPlaying;
        Template1State.videoPlayerController!.pause();
      }
    }
    return check;
  }

  void after(bool check) {
    if (controller.index == 1) {
      if (LiveTvScreenState.videoPlayerController != null) {
        if (check) {
          LiveTvScreenState.videoPlayerController!.play();
        }
      }
    } else if (controller.index == 0) {
      if (Template1State.videoPlayerController != null) {
        if (check) {
          Template1State.videoPlayerController!.play();
        }
      }
    }
    setState(() {});
  }

  Future<bool> onWillPop() async {
    if (currentIndex != 0) {
      currentIndex = 0;
      setState(() {});
    } else {
      warningExitApp(context);
    }
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: Colors.transparent,
        // drawer: Drawer(
        //   elevation: 0,
        //   backgroundColor: Theme.of(context).primaryColor,
        //   child:
        //       BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        //     if (state is CategoryLoaded) {
        //       List<DrawerTab> a = [];
        //       a.add(DrawerTab(
        //           name: AppLocalizations.of(context)!.translate('Home'),
        //           icon: Icons.home_outlined,
        //           onTap: () {
        //             if (controller.index != 0 || currentIndex != 0) {
        //               setState(() {
        //                 controller.index = 0;
        //                 currentIndex = 0;
        //               });
        //             }
        //             Future.delayed(const Duration(milliseconds: 10))
        //                 .then((value) => homeController.index = 0);
        //             Navigator.pop(context);
        //           }));
        //       for (int i = 0; i < state.details.newsCategory!.length; i++) {
        //         a.add(DrawerTab(
        //             name: state.details.newsCategory![i].name!,
        //             icon: Icons.arrow_forward,
        //             onTap: () {
        //               if (controller.index != 0 || currentIndex != 0) {
        //                 setState(() {
        //                   controller.index = 0;
        //                   currentIndex = 0;
        //                 });
        //               }
        //               Future.delayed(const Duration(milliseconds: 10))
        //                   .then((value) => homeController.index = i + 1);
        //               Navigator.pop(context);
        //             }));
        //       }
        //       drawerList = a;
        //     }
        //     return ListView(
        //       shrinkWrap: true,
        //       physics: const BouncingScrollPhysics(),
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 25),
        //           child: Text(
        //             sessionHelper!.get(SessionHelper.name) == null
        //                 ? "Guest"
        //                 : sessionHelper!.get(SessionHelper.name)!,
        //             style: TextStyle(
        //                 color: Theme.of(context).textTheme.displayLarge!.color,
        //                 fontSize: 20),
        //           ),
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             Text(
        //                 AppLocalizations.of(context)!
        //                     .translate("Trade Link India"),
        //                 style: TextStyle(
        //                     color: ColorsConstants.logoColor,
        //                     fontSize: 20,
        //                     fontWeight: FontWeight.bold)),
        //             // switchWidget(context)
        //           ],
        //         ),
        //         const SizedBox(
        //           height: 10,
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             CustomElevatedButton(
        //                 text: "Hindi",
        //                 onPressed: () {
        //                   appLanguage.changeLanguage(const Locale("hi"));
        //                 }),
        //             CustomElevatedButton(
        //                 text: "English",
        //                 onPressed: () {
        //                   appLanguage.changeLanguage(const Locale("en"));
        //                 }),
        //           ],
        //         ),
        //         ListView.builder(
        //           itemCount: drawerList.length,
        //           physics: const NeverScrollableScrollPhysics(),
        //           shrinkWrap: true,
        //           itemBuilder: (context, index) {
        //             return listTileWidget(
        //                 drawerList[index].name, drawerList[index].icon, context,
        //                 onTap: drawerList[index].onTap);
        //           },
        //         ),
        //         listTileWidget(
        //             AppLocalizations.of(context)!.translate('Submit Your News'),
        //             Icons.report_gmail_error_red_outlined,
        //             context, onTap: () {
        //           bool check = before();
        //           Navigator.popAndPushNamed(
        //             context,
        //             "/submitYourNews",
        //           ).then((value) {
        //             after(check);
        //           });
        //         }),
        //         listTileWidget(
        //             AppLocalizations.of(context)!.translate("Subscription Plan"),
        //             Icons.subscriptions_outlined,
        //             context, onTap: () {
        //           bool check = before();
        //           Navigator.popAndPushNamed(
        //             context,
        //             "/subscriptionPlan",
        //           ).then((value) {
        //             after(check);
        //           });
        //         }),
        //         if (sessionHelper!.get(SessionHelper.userId) == null)
        //           listTileWidget(AppLocalizations.of(context)!.translate('Login'),
        //               Icons.login_outlined, context, onTap: () {
        //             bool check = before();
        //             Navigator.popAndPushNamed(
        //               context,
        //               "/login",
        //             ).then((value) {
        //               after(check);
        //             });
        //           }),
        //         listTileWidget(
        //             AppLocalizations.of(context)!
        //                 .translate("Terms and Conditions"),
        //             Icons.my_library_books_outlined,
        //             context, onTap: () {
        //           bool check = before();
        //           Navigator.popAndPushNamed(
        //             context,
        //             "/termsAndConditions",
        //           ).then((value) {
        //             after(check);
        //           });
        //         }),
        //         listTileWidget(
        //             AppLocalizations.of(context)!.translate("My Favorite"),
        //             Icons.monitor_heart_outlined,
        //             context, onTap: () {
        //           bool check = before();
        //           Navigator.popAndPushNamed(
        //             context,
        //             "/myFavorite",
        //           ).then((value) {
        //             after(check);
        //           });
        //         }),
        //         logo(height: 150, width: 100),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             iconTapWidget(ImagesConstants.facebookLogo, () {
        //               bool check = before();
        //               Navigator.pushNamed(context, "/webView",
        //                       arguments: "https://www.facebook.com/")
        //                   .then((value) {
        //                 after(check);
        //               });
        //             }),
        //             iconTapWidget(ImagesConstants.instagramLogo, () {
        //               bool check = before();
        //
        //               Navigator.pushNamed(context, "/webView",
        //                       arguments:
        //                           "https://www.instagram.com/narendramodi/?hl=en")
        //                   .then((value) {
        //                 after(check);
        //               });
        //             }),
        //             iconTapWidget(ImagesConstants.twitterLogo, () {
        //               bool check = before();
        //
        //               Navigator.pushNamed(context, "/webView",
        //                       arguments: "https://twitter.com")
        //                   .then((value) {
        //                 after(check);
        //               });
        //             }),
        //           ],
        //         )
        //       ],
        //     );
        //   }),
        // ),
        body: Stack(
          children: [
            if (_screens.isNotEmpty) _screens[currentIndex],
            logoStick(onTap: () {
              // setState(() {
              //   controller.index = 0;
              //   currentIndex = 0;
              //   homeController.index = 0;
              // });
              // videoPlayerController.play();
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.background,
          onPressed: () {
            currentScreen = false;
            setScreen(context);
            Navigator.pushNamed(context, "/search").then((value) {
              currentScreen = true;
              setScreen(context);
            });
          },
          child: const Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          shadow: Shadow(
            color: ColorsConstants.black.withOpacity(.2),
            blurRadius: 5,
          ),
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color =
                isActive ? Theme.of(context).secondaryHeaderColor : Colors.grey;
            return Padding(
                padding: const EdgeInsets.all(17),
                child: SvgPicture.asset(
                  iconList[index],
                  colorFilter: AppConstant.getColorFilter(color),
                ));
          },
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          activeIndex: currentIndex,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 10,
          rightCornerRadius: 10,
          onTap: (index) => setState(() => currentIndex = index),
        ),
      ),
    );
  }
}
