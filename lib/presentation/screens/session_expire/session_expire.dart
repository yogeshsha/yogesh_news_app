import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/presentation/widgets/primary_button_component.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import '../../../constants/app_constant.dart';
import '../../../constants/colors_constants.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/session_data/session_bloc/session_bloc.dart';
import '../../../utils/app.dart';

class SessionExpiredScreen extends StatefulWidget {
  const SessionExpiredScreen({super.key});

  @override
  State<SessionExpiredScreen> createState() => _SessionExpiredScreenState();
}

class _SessionExpiredScreenState extends State<SessionExpiredScreen> {
  bool isLoading = true;
  bool checkError = true;
  bool currentScreen = true;

  @override
  void initState() {
    callSession(context);
    super.initState();
  }

  void callSession(BuildContext context) {
    context.read<SessionBloc>.call().add(const GetSessionEvent());
  }

  void callInitialSession(BuildContext context) {
    context.read<SessionBloc>.call().add(const FetchInitialSession());
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<SessionBloc, SessionState>(builder: (context, state) {
      if (currentScreen) {
        if (state is SessionLoading) {
          isLoading = true;
          checkError = true;
        } else if (state is SessionInitial) {
          isLoading = false;
          checkError = true;
        } else if (state is SessionError) {
          sessionError(context, state);
        } else if (state is OtherStatusCodeSession) {
          otherSessionState(context, state);
        } else if (state is SessionLoaded) {
          sessionLoaded(context, state);
        }
      }
      return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SizedBox(
            height: mediaHeight,
            width: mediaWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: mediaHeight * .20,
                ),
                SvgPicture.asset(ImagesConstants.session),
                TextAll(
                    text: "Session Expire",
                    weight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                    max: 26),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mediaWidth * 0.3),
                  child: SimpleText(
                    text: "Log in again to pick up where you left off.",
                    alignment: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorsConstants.textGrayColor),
                  ),
                ),
                SizedBox(
                  height: mediaHeight * .040,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButtonComponent(
                          title: "Home",
                          onTap: () async {
                            SessionHelper().clear();
                            await SessionHelper.getInstance(context);
                            SessionHelper()
                                .put(SessionHelper.firstTimeLogin, "true");
                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/home", (route) => false);
                            }
                          }),
                    ),
                    Expanded(
                      child: PrimaryButtonComponent(
                          title: "Login",
                          onTap: () {
                            Navigator.pushNamed(context, "/login");
                          }),
                    ),
                  ],
                )
              ],
            ),
          ));
    });
  }

  void otherSessionState(BuildContext context, OtherStatusCodeSession state) {
    callInitialSession(context);
    if (state.details.statusCode == 401 || state.details.statusCode == 403) {
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      //   if (checkError) {
      //     checkError = false;
      //     Navigator.pushNamed(context, "/sessionExpired")
      //         .then((value) => callSession(context));
      //   }
      // });
    } else if (state.details.statusCode == 500) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
            .then((value) => callSession(context));
      });
    } else {
      if (checkError) {
        checkError = false;
        isLoading = false;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.details.message ?? ""));
        });
      }
    }
  }

  void sessionError(BuildContext context, SessionError state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        callInitialSession(context);
        String errorMessage = AppConstant.errorMessage(state.message);
        if (AppConstant.checkConnectionTimeOut(errorMessage)) {
          Navigator.pushNamed(context, "/connectionTimeout")
              .then((value) => callSession(context));
        } else {
          AppHelper.showSnakeBar(context, errorMessage);
        }
      });
    }
  }

  void sessionLoaded(BuildContext context, SessionLoaded state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.setUser(state.model);
        if (context.mounted) {
          callInitialSession(context);
          Navigator.pop(context);
        }
      });
    }
  }
}
