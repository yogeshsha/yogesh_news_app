import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/loader.dart';
import 'package:newsapp/utils/app.dart';

import '../../../constants/app_constant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/common_model/text_span_model.dart';
import '../../../constants/images_constants.dart';
import '../../../data/login_data/login_bloc/login_bloc.dart';
import '../../widgets/ink_well_custom.dart';
import '../../widgets/primary_button_component.dart';
import '../../widgets/rich_text.dart';
import '../../widgets/simple_text.dart';
import '../../widgets/text_common.dart';
import '../../widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  final bool checkBackButton;
  final bool sessionExpired;

  const LoginScreen(
      {super.key, required this.checkBackButton, this.sessionExpired = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isHidePassWord = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool checkError = true;

  @override
  void initState() {
    callLoginInitial(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void callLoginInitial(BuildContext context) {
    context.read<LoginBloc>().add(const FetchInitialLogin());
  }

  void callLoginApi(BuildContext context) {
    context.read<LoginBloc>.call().add(FetchLogin(body: {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    }));
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginLoading) {
        isLoading = true;
        checkError = true;
      } else if (state is LoginInitial) {
        isLoading = false;
        checkError = true;
      } else if (state is LoginError) {
        loginError(context, state);
      } else if (state is LoginLoaded) {
        loginLoaded(context, state);
      } else if (state is OtherStatusCodeLoginLoaded) {
        otherStatusCodeLogin(context, state);
      }
      return Stack(
        children: [
          Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SafeArea(
              child: Stack(
                children: [
                  SvgPicture.asset(ImagesConstants.appImageOne),
                  Form(
                    key: formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: mediaHeight,
                      width: mediaWidth,
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
                                  if (widget.checkBackButton) {
                                    Navigator.pop(context);
                                  } else {
                                    AppHelper.navigateToHome(context);
                                  }
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
                            SizedBox(height: mediaHeight * .12),
                            const SimpleText(
                                alignment: TextAlign.center,
                                text: "Let’s Sign You in!",
                                weight: FontWeight.w700,
                                size: 36),
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 50, right: 50, bottom: 10),
                              child: SimpleText(
                                alignment: TextAlign.center,
                                text: "Welcome back you have been missed!",
                                size: 16,
                              ),
                            ),
                            SvgPicture.asset(ImagesConstants.redHart),
                            TextFormFieldWidget(
                              margin: const EdgeInsets.only(top: 50),
                              borderCurve: 10,
                              controller: emailController,
                              label: "Enter Email Id",
                              type: TextInputType.emailAddress,
                              compulsory: false,
                              // inputFormatters: [AppConstant.emailFormatter],
                              validation: (value) {
                                if (value.trim().isEmpty) {
                                  return AppHelper.getDynamicString(
                                      context, "Enter Email");
                                }
                                if (value.trim().isNotEmpty &&
                                    !EmailValidator.validate(value)) {
                                  return AppHelper.getDynamicString(
                                      context, "Incorrect Email Format");
                                }
                                return null;
                              },
                            ),
                            TextFormFieldWidget(
                                margin: const EdgeInsets.only(top: 15),
                                borderCurve: 10,
                                controller: passwordController,
                                hide: isHidePassWord,
                                label: "Password",
                                validation: (value) {
                                  if (value.trim().isEmpty) {
                                    return AppHelper.getDynamicString(
                                        context, "Enter your Password");
                                  }
                                  return null;
                                },
                                suffix: InkWellCustom(
                                    onTap: () {
                                      isHidePassWord = !isHidePassWord;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: ColorsConstants.textGrayColor,
                                    ))),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Spacer(),
                                InkWellCustom(
                                    onTap: () {},
                                    child: TextAll(
                                        text: "Forgot Password ?",
                                        weight: FontWeight.w600,
                                        color: ColorsConstants.textGrayColor,
                                        max: 12)),
                              ],
                            ),
                            const SizedBox(height: 30),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Container(
                            //         height: 1,
                            //         color: ColorsConstants.textGrayColorLightTwo,
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding:
                            //           const EdgeInsets.symmetric(horizontal: 8),
                            //       child: TextAll(
                            //           text: "Or",
                            //           weight: FontWeight.w500,
                            //           color: ColorsConstants.textGrayColor,
                            //           max: 14),
                            //     ),
                            //     Expanded(
                            //       child: Container(
                            //         height: 1,
                            //         color: ColorsConstants.textGrayColorLightTwo,
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const ShareBox(
                            //       icon: Icon(
                            //         Icons.apple_sharp,
                            //         size: 30,
                            //       ),
                            //     ),
                            //     ShareBox(
                            //       svgImage: SvgPicture.asset(
                            //           ImagesConstants.googleSvg,
                            //           height: 20,
                            //           width: 20),
                            //       margin: const EdgeInsets.symmetric(
                            //           horizontal: 15, vertical: 25),
                            //     ),
                            //     Container(
                            //       height: 50,
                            //       width: 50,
                            //       decoration: BoxDecoration(
                            //           border: Border.all(
                            //               color: ColorsConstants.textGrayColor),
                            //           borderRadius: BorderRadius.circular(12)),
                            //       child: Center(
                            //           child: Container(
                            //               height: 27,
                            //               width: 27,
                            //               padding: const EdgeInsets.all(6),
                            //               decoration: BoxDecoration(
                            //                   shape: BoxShape.circle,
                            //                   color:
                            //                       ColorsConstants.faceBookColor),
                            //               child: SvgPicture.asset(
                            //                 ImagesConstants.facebook,
                            //                 colorFilter:  AppConstant.getColorFilter(ColorsConstants.white),
                            //               ))),
                            //     )
                            //   ],
                            // ),
                            const SizedBox(height: 50),

                            PrimaryButtonComponent(
                              backGroundColor: ColorsConstants.appColor,
                              textColor: ColorsConstants.white,
                              title: "Sign In",
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  callLoginApi(context);
                                }
                              },
                            ),
                            const SizedBox(height: 15),
                            RichTextComponent2(list: [
                              TextSpanModel(
                                  title: "Don’t have an account ?",
                                  style: GoogleFonts.poppins(
                                      color: AppColor.textGrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12)),
                              TextSpanModel(
                                  title: "Sign Up",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsConstants.skyBlue),
                                  onTap: () {
                                    Navigator.pushNamed(context, "/signUp",
                                        arguments: {
                                          "checkBackButton":
                                              widget.checkBackButton,
                                          "sessionExpired":
                                              widget.sessionExpired
                                        });
                                  })
                            ]),

                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading) const Loading()
        ],
      );
    });
  }

  void otherStatusCodeLogin(
      BuildContext context, OtherStatusCodeLoginLoaded state) {
    callLoginInitial(context);

    AppHelper.myPrint(
        "----------------- Inside Other Status Code Login -----------");
    if (checkError) {
      checkError = false;
      if (state.details.statusCode == 401 || state.details.statusCode == 403) {
        Map map = {};
        map['check'] = true;
        map['hideSocialLogin'] = false;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/sessionExpired")
              .then((value) => callLoginInitial(context));
        });
      }else if (state.details.statusCode == 500) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
              .then((value) => callLoginInitial(context));
        });
      }  else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.details.message ?? ""));
        });
      }
    }
  }

  void loginError(BuildContext context, LoginError state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(
            context, AppConstant.errorMessage(state.message));
      });
    }
    callLoginInitial(context);
  }

  void loginLoaded(BuildContext context, LoginLoaded state) {
    AppHelper.setUser(state.details);
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (widget.checkBackButton) {
          Navigator.pop(context);
        } else {
          SessionHelper().put(SessionHelper.firstTimeLogin, "true");
          if ((SessionHelper().get(SessionHelper.profileStatus) ?? "0") ==
              "0") {
            Navigator.pushNamedAndRemoveUntil(
                context, "/signInThirdScreen", (route) => false);
          } else if ((SessionHelper().get(SessionHelper.profileStatus) ??
                  "0") ==
              "1") {
            Navigator.pushNamedAndRemoveUntil(
                context, "/subscriptionScreen", (route) => false);
          } else {
            AppHelper.navigateToHome(context);
          }
        }
      });
    }
    callLoginInitial(context);
  }
}
