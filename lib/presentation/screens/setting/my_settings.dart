import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/presentation/screens/setting/component/theme_component.dart';
import 'package:newsapp/presentation/screens/setting/component/toggle_setting_component.dart';
import 'package:newsapp/utils/share_chat.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constant.dart';
import '../../../data/settings_data/settings_bloc/settings_bloc.dart';
import '../../../utils/app.dart';
import '../../../utils/dark_theme_provider.dart';
import '../../widgets/loader.dart';
import '../../widgets/text_common.dart';
import '../popups/pop_ups_screen.dart';
import 'component/common_app_bar_component.dart';
import 'component/log_out_component.dart';
import 'component/bookmark_component.dart';
import 'component/notification_component.dart';
import 'component/theme_component.dart';

class MySettings extends StatefulWidget {
  final Function navigateToHome;

  const MySettings({super.key, required this.navigateToHome});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  bool isLoading = false;
  bool checkError = true;

  DarkThemeProvider themeChange = DarkThemeProvider();
  List<DropdownMenuItem<String>> fontSizeList = [];
  String initialFontValue = "medium";
  bool fontSizeLoader = false;
  bool darkMode = true;
  bool autoDownload = true;
  bool smartDownload = true;

  @override
  void initState() {
    setData(context);
    super.initState();
  }

  void setData(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialFontValue =
          SessionHelper().get(SessionHelper.fontSize) ?? initialFontValue;

      themeChange = Provider.of<DarkThemeProvider>(context, listen: false);

      fontSizeLoader = false;
      darkMode = themeChange.darkTheme;

      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        fontSizeList = [
          DropdownMenuItem(
              value: "small",
              child: TextAll(
                textDynamic: true,
                text: "Small",
                color: Theme.of(context).colorScheme.secondary,
                weight: FontWeight.w400,
                max: 14,
              )),
          DropdownMenuItem(
              value: "medium",
              child: TextAll(
                textDynamic: true,
                text: "Medium",
                color: Theme.of(context).colorScheme.secondary,
                weight: FontWeight.w400,
                max: 14,
              )),
          DropdownMenuItem(
              value: "large",
              child: TextAll(
                textDynamic: true,
                text: "Large",
                color: Theme.of(context).colorScheme.secondary,
                weight: FontWeight.w400,
                max: 14,
              )),
        ];
        setState(() {});
      });
    });
  }

  void callSettingsInitial(BuildContext context) {
    context.read<SettingsBloc>().add(const FetchInitialSettings());
  }

  void callLogOutApi(BuildContext context, Map body) {
    context.read<SettingsBloc>.call().add(LogoutEvent(body: body));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      if (state is SettingsLoading) {
        isLoading = true;
        checkError = true;
      } else if (state is SettingsInitial) {
        isLoading = false;
        checkError = true;
      } else if (state is SettingsError) {
        settingsError(context, state);
      } else if (state is LogOutLoaded) {
        logOutLoaded(context, state);
      } else if (state is OtherStatusCodeSettingsLoaded) {
        otherStatusCodeSettings(context, state);
      }
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CommonAppBarComponent(
                  title: "Settings",
                  onTapBackArrow: () {
                    widget.navigateToHome();
                  },
                ),
              ),
              // const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  primary: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      NotificationComponent(
                        onTapAppNotification: () {
                          if (AppHelper.checkUser()) {
                            Navigator.pushNamed(context, "/notification");
                          } else {
                            AppHelper.navigateToRegister(
                                context: context,
                                onUserFound: () {
                                  Navigator.pushNamed(context, "/notification");
                                });
                          }
                        },
                      ),
                      Divider(
                        color: ColorsConstants.dividerColor,
                      ),
                      BookmarkComponent(
                        onTapBookmark: () {
                          Navigator.pushNamed(context, "/showBookmark")
                          //     .then((value) {
                          //   if (value is String) {
                          //     AppHelper.myPrint(
                          //         "------------- Scan Value --------------");
                          //     AppHelper.myPrint(value);
                          //     AppHelper.myPrint("---------------------------");
                          //     ShareChat.changeScreen(value);
                          //   }
                          // })
                          ;
                        },
                        onTapAccount: () {
                          Navigator.pushNamed(context, "/account");
                        },
                      ),
                      Divider(
                        color: ColorsConstants.dividerColor,
                      ),
                      ThemeComponent(
                          fontSizeLoader: fontSizeLoader,
                          onChange: (String value) {
                            initialFontValue = value;
                            SessionHelper().put(SessionHelper.fontSize, value);
                            setState(() {});
                          },
                          initialValue: initialFontValue,
                          hint: "Select Font Size",
                          list: fontSizeList,
                          onChangeDarkMode: (bool value) {
                            fontSizeLoader = true;

                            darkMode = value;
                            themeChange.darkTheme = value;
                            setData(context);
                            setState(() {});
                          },
                          darkModeValue: darkMode),
                      Divider(
                        color: ColorsConstants.dividerColor,
                      ),
                      ToggleSettingComponent(
                        toggleValue: autoDownload,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        onChange: (bool value) {
                          autoDownload = value;
                          setState(() {});
                        },
                        title: "Auto-Download Save Media",
                        titleStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary),
                        subTitle:
                            "Downloads save media when Wi-Fi is available",
                        subTitleStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      Divider(
                        color: ColorsConstants.dividerColor,
                      ),
                      ToggleSettingComponent(
                        toggleValue: smartDownload,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        onChange: (bool value) {
                          smartDownload = value;
                          setState(() {});
                        },
                        title: "Smart-Download Latest news",
                        titleStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary),
                        subTitle:
                            "Downloads save media when Wi-Fi is available",
                        subTitleStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      Divider(
                        color: ColorsConstants.dividerColor,
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const Center(
                              child:
                                  CustomCircularLoader(height: 40, width: 40))
                          : LogOutComponent(onTapLogIn: () {
                              AppHelper.navigateToRegister(
                                  context: context,
                                  onUserFound: () {
                                    setState(() {});
                                  });
                            }, onTapLogOut: () {
                              AllPopUi.warning(
                                  isShowLogout: true,
                                  context: context,
                                  title: "Log Out",
                                  subTitle: "Are You Sure",
                                  onPressed: (bool value) {
                                    Navigator.pop(context);
                                    Map map = {"logoutFromAllDevice": value};
                                    callLogOutApi(context, map);
                                  });
                            }),
                      const SizedBox(height: 50)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void otherStatusCodeSettings(
      BuildContext context, OtherStatusCodeSettingsLoaded state) {
    callSettingsInitial(context);

    AppHelper.myPrint(
        "----------------- Inside Other Status Code Settings -----------");
    if (checkError) {
      checkError = false;
      if (state.details.statusCode == 401 || state.details.statusCode == 403) {
        Map map = {};
        map['check'] = true;
        map['hideSocialSettings'] = false;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/sessionExpired")
              .then((value) => callSettingsInitial(context));
        });
      } else if (state.details.statusCode == 500) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
              .then((value) => callSettingsInitial(context));
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.details.message ?? ""));
        });
      }
    }
  }

  void settingsError(BuildContext context, SettingsError state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(
            context, AppConstant.errorMessage(state.message));
      });
    }
    callSettingsInitial(context);
  }

  void logOutLoaded(BuildContext context, LogOutLoaded state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(
            context, AppConstant.errorMessage(state.details));
        AppHelper.clearSession(context);
      });
    }

    callSettingsInitial(context);
  }
}
