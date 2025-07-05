import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';

import '../../../constants/app_constant.dart';
import '../../../data/splash_data/splash_bloc/splash_bloc.dart';
import '../../../utils/app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool checkError = true;
  bool isLoading = false;
  bool isScreenMounted = true;

  @override
  void initState() {
    initializeSession(context);
    super.initState();
  }

  void initializeSession(BuildContext context) async {
    if (context.mounted) {
      await SessionHelper.getInstance(context);
      if (SessionHelper().get(SessionHelper.userId) != null) {
        if (context.mounted) {
          callUserDetails(context);
        }
      } else {
        if (context.mounted) {
          Future.delayed(const Duration(seconds: 1)).then((value) {
            navigate(context);
          });
        }
      }
    }
  }

  void callUserDetails(BuildContext context) {
    if (AppHelper.checkUser()) {
      context.read<SplashBloc>.call().add(const GetUserDetails());
    } else {
      navigate(context);
    }
  }

  void navigate(BuildContext context, {bool navigateHome = false}) {
    Future.delayed(const Duration(seconds: 0)).then((value) {
      if (context.mounted) {
        if (SessionHelper().get(SessionHelper.firstTimeLogin) == null &&
            !navigateHome) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/infoScreen", (route) => false);
        } else {
          if(SessionHelper().get(SessionHelper.userId) == null){
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          }else if ((SessionHelper().get(SessionHelper.profileStatus) ?? "0") ==
              "0") {
            Navigator.pushNamedAndRemoveUntil(
                context, "/signInThirdScreen", (route) => false);
          } else if ((SessionHelper().get(SessionHelper.profileStatus) ??
                  "0") ==
              "1") {
            Navigator.pushNamedAndRemoveUntil(
                context, "/subscriptionScreen", (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          }
        }
      }
    });
  }

  void callInitialSplash(BuildContext context) {
    context.read<SplashBloc>.call().add(const FetchInitialSplash());
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
      if (isScreenMounted) {
        if (state is SplashMainLoaded) {
          splashMainLoaded(context, state);
        } else if (state is SplashLoading) {
          isLoading = true;
        } else if (state is SplashInitial) {
          checkError = true;
          isLoading = false;
        } else if (state is SplashError) {
          splashError(context, state);
        } else if (state is OtherStatusCodeSplash) {
          otherStatusCodeSplash(context, state);
        }
      }
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: Stack(
          children: [
            Center(child: SvgPicture.asset(ImagesConstants.circleSplash)),
            SizedBox(
              width: mediaWidth,
              height: mediaHeight,
              child: Center(
                  child: TextAll(
                      text: "TRADELINK INDIA",
                      weight: FontWeight.w700,
                      color: Theme.of(context).secondaryHeaderColor,
                      max: 30)),
            ),
          ],
        )),
      );
    });
  }

  void splashError(BuildContext context, SplashError state) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      isScreenMounted = false;
      Navigator.pushNamed(context, "/connectionTimeout").then((value) {
        isScreenMounted = true;
        callUserDetails(context);
      });
    });
    callInitialSplash(context);
  }

  void otherStatusCodeSplash(
      BuildContext context, OtherStatusCodeSplash state) {
    AppHelper.myPrint(
        "---------------- Splash Other Status Code -------------------");

    callInitialSplash(context);

    if (state.details.statusCode == 401 || state.details.statusCode == 403) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (checkError) {
          checkError = false;
          isScreenMounted = false;
          Navigator.pushNamed(context, "/sessionExpired").then((value) {
            isScreenMounted = true;
            callUserDetails(context);
          });
        }
      });
    } else if (state.details.statusCode == 500) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
            .then((value) => callUserDetails(context));
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        isScreenMounted = false;
        Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
            .then((value) {
          isScreenMounted = true;
          callUserDetails(context);
        });
      });
    }
  }

  Future<void> splashMainLoaded(
      BuildContext context, SplashMainLoaded state) async {
    callInitialSplash(context);
    AppHelper.setUser(state.user);
    navigate(context, navigateHome: true);
  }
}
