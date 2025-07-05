
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_constant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/images_constants.dart';
import '../../../data/sign_up_data/sign_up_bloc/sign_up_bloc.dart';
import '../../../utils/app.dart';
import '../../widgets/ink_well_custom.dart';
import '../../widgets/simple_text.dart';
import '../../widgets/square_tick_box.dart';
import '../../widgets/text_common.dart';
import '../../widgets/text_form_field.dart';
import '../sign_in_screen/component/bottom_button_component.dart';

class SignUpScreen extends StatefulWidget {
  final bool checkBackButton;
  final bool sessionExpired;
  const SignUpScreen({super.key, required this.checkBackButton,this.sessionExpired = false});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  bool isHidePassWord = true;
  bool isAgree= false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool checkError = false;
  bool isLoading = false;



  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void callLoginInitial(BuildContext context) {
    context
        .read<SignUpBloc>()
        .add(FetchInitialSignUp(body: const {}));
  }

  void callSignUpApi(BuildContext context) {
    context.read<SignUpBloc>.call().add(FetchSignUp(body: {
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
      "name": _nameController.text.trim()
    }));
  }


  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
   return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      if (state is SignUpLoading) {
        isLoading = true;
        checkError = true;
      } else if (state is SignUpInitial) {
        isLoading = false;
        checkError = true;
      } else if (state is SignUpError) {
        signUpError(context, state);
      }else if(state is SignUpLoaded){
        signUpLoaded(context, state);
      }else if(state is OtherStatusCodeSignUpLoaded){
        otherStatusCodeLogin(context, state);
      }
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: SizedBox(
            height: mediaHeight,
            width: mediaWidth,
            child: Stack(
              children: [
                SvgPicture.asset(ImagesConstants.appImageOne),

                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // height: mediaHeight,
                    // width: mediaWidth,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: InkWellCustom(
                                onTap: (){
                                  if(widget.checkBackButton){
                                    Navigator.pop(context);
                                  }else{
                                    AppHelper.navigateToHome(context);
                                  }

                                },
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    SizedBox(
                                      height: 25,
                                      child: Center(
                                        child: TextAll(text: "Skip for now",
                                            weight: FontWeight.w600, color: ColorsConstants.textGrayColor, max: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: mediaHeight*.07),
                            SvgPicture.asset(ImagesConstants.redHart,height: 40,width: 40,),
                            SizedBox(height: mediaHeight*.012),
                            const SimpleText(alignment:TextAlign.center,text: "Create Your Profile!",weight: FontWeight.w700,size: 28),
                            const Padding(
                              padding: EdgeInsets.only(left: 50,right: 50,bottom: 10),
                              child: SimpleText(alignment: TextAlign.center,text: "Headlines that matter, at your fingertips.",size: 14,),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,color: ColorsConstants.appColor

                            ),),



                            TextFormFieldWidget(
                              borderCurve: 10,

                              controller: _nameController,
                              label: "Enter Name",
                              validation: (value) {
                                if(value.trim().isEmpty) {
                                  return AppHelper.getDynamicString(context,"Enter Your Name");
                                }
                                return null;
                              },
                            ),
                            TextFormFieldWidget(
                              margin: const EdgeInsets.only(top: 5),
                              borderCurve: 10,
                              controller: _emailController,
                              label: "Enter Email Id",
                              type: TextInputType.emailAddress,
                              compulsory: false,
                              inputFormatters: [
                                AppConstant.emailFormatter
                              ],
                              validation: (value) {
                                if(value.trim().isEmpty){
                                  return AppHelper.getDynamicString(context,"Enter Email");

                                }else if(value.trim().isNotEmpty) {
                                  if (!EmailValidator.validate(value)) {
                                    return AppHelper.getDynamicString(context,"Incorrect Email Format");
                                  }
                                }
                                return null;
                              },
                            ),
                            TextFormFieldWidget(
                                margin: const EdgeInsets.only(top: 15),
                                borderCurve: 10,
                                controller: _passwordController,
                                hide: isHidePassWord,
                                label: "Password",
                                validation: (value) {
                                  if (value.trim().isEmpty) {
                                    return AppHelper.getDynamicString(context,"Enter your Password");
                                  }
                                  return null;
                                },
                                suffix:InkWellCustom(
                                    onTap:(){
                                      isHidePassWord = !isHidePassWord;
                                      setState(() {
                                      });
                                    },
                                    child: Icon(Icons.remove_red_eye_outlined,color: ColorsConstants.textGrayColor,))
                            ),
                            TextFormFieldWidget(
                                margin: const EdgeInsets.only(top: 15),
                                borderCurve: 10,
                                controller: _confirmPasswordController,
                                hide: isHidePassWord,
                                label: "Confirm Password",
                                validation: (value) {
                                  if (value.trim().isEmpty) {
                                    return AppHelper.getDynamicString(context,"Enter your Password");
                                  }
                                  if(value.trim().isNotEmpty && _passwordController.text.trim() != _confirmPasswordController.text.trim()){
                                    return AppHelper.getDynamicString(context,"Password Not Mach");
                                  }
                                  return null;
                                },
                                suffix:InkWellCustom(
                                    onTap:(){
                                      isHidePassWord = !isHidePassWord;
                                      setState(() {
                                      });
                                    },
                                    child: Icon(Icons.remove_red_eye_outlined,color: ColorsConstants.textGrayColor,))
                            ),
                            const SizedBox(height: 10),

                            Wrap(
                              children: [
                                SquareTickBoxComponent(
                                    textColor: ColorsConstants.textGrayColor,
                                    initialValue: isAgree,
                                    textSize: 12,
                                    onChange: (bool value){
                                      isAgree = value;
                                      setState(() {});
                                    },
                                    text: "Tick checkbox to agree"),
                                const SizedBox(width: 5),
                                TextAll(
                                    underLine: true,
                                    text: "Terms & conditions",
                                    weight: FontWeight.w600, color: Theme.of(context).colorScheme.primary, max: 12
                                )
                              ],
                            ),


                            const SizedBox(height: 150),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BottomButtonComponent(
                    onTapLeft: (){
                      Navigator.pop(context);
                    },
                    onTapRight: (){
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if(!isAgree){
                          AppHelper.showSnakeBar(context, "Allow Terms & Condition");
                          return;
                        }
                        callSignUpApi(context);
                        // Navigator.pushNamed(context, "/signInThirdScreen");
                      }

                    })
              ],
            ),
          ),
        ),
      );
   });
  }

  void otherStatusCodeLogin(
      BuildContext context, OtherStatusCodeSignUpLoaded state) {
    callLoginInitial(context);

    AppHelper.myPrint(
        "----------------- Inside Other Status Code Login -----------");
    if(checkError){
      checkError = false;
      if (state.details.statusCode == 401 || state.details.statusCode == 403) {
        Map map = {};
        map['check'] = true;
        map['hideSocialLogin'] = false;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/sessionExpired")
              .then((value) => callLoginInitial(context));
        });
      } else if (state.details.statusCode == 500) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, "/connectionTimeout", arguments: true)
              .then((value) => callLoginInitial(context));
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          AppHelper.showSnakeBar(
              context, AppConstant.errorMessage(state.details.message ?? ""));
        });
      }
    }

  }

  void signUpError(BuildContext context, SignUpError state) {
    if (checkError) {
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppHelper.showSnakeBar(
            context, AppConstant.errorMessage(state.message));
      });
    }
    callLoginInitial(context);
  }

  void signUpLoaded(BuildContext context, SignUpLoaded state) {
    AppHelper.setUser(state.details);
    if(checkError){
      checkError = false;
      SchedulerBinding.instance.addPostFrameCallback((_) {
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
      });
    }

    callLoginInitial(context);
  }
}
