import 'package:flutter/material.dart';
import 'package:newsapp/presentation/widgets/primary_button_component.dart';
import 'package:newsapp/utils/app.dart';

class LogOutComponent extends StatelessWidget {
  final Function onTapLogIn;
  final Function onTapLogOut;

  const LogOutComponent(
      {super.key, required this.onTapLogIn, required this.onTapLogOut});

  @override
  Widget build(BuildContext context) {
    bool isLogin = AppHelper.checkUser();
    return PrimaryButtonComponent(
      onTap: () {
        isLogin ? onTapLogOut() : onTapLogIn();
      },
      title: isLogin ? "Log Out" : "Log In",
      textColor: Theme.of(context).secondaryHeaderColor,
      allowBorder: true,
      borderColor: Theme.of(context).secondaryHeaderColor,
      backGroundColor: Theme.of(context).primaryColor,
    );
  }
}
