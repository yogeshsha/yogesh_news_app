import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors_constants.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:newsapp/presentation/screens/account/component/option_component.dart';
import 'package:newsapp/presentation/screens/setting/component/common_app_bar_component.dart';
import 'package:newsapp/presentation/widgets/text_common.dart';
import 'package:newsapp/utils/app.dart';

class Account extends StatefulWidget {
  // final Function navigateToHome;

  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        height: mediaHeight,
        width: mediaWidth,
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: CommonAppBarComponent(
                title: "Account"
              ),
            ),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: ColorsConstants.textFieldColor,
                          shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppHelper.checkUser()
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (AppHelper.getUserName().trim().isNotEmpty)
                                  TextAll(
                                      text: AppHelper.getUserName(),
                                      weight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      max: 14),
                                if (AppHelper.getUserEmail().trim().isNotEmpty)
                                  TextAll(
                                      text: AppHelper.getUserEmail(),
                                      weight: FontWeight.w400,
                                      color: ColorsConstants.textGrayColor,
                                      max: 11)
                              ],
                            )
                          : TextAll(
                              align: TextAlign.start,
                              text: "Guest",
                              weight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary,
                              max: 22),
                    ),
                    if (AppHelper.checkUser())
                      Container(
                        decoration: BoxDecoration(
                            color: ColorsConstants.appColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: TextAll(
                              text: "Edit Profile",
                              weight: FontWeight.w500,
                              color: ColorsConstants.white,
                              max: 10),
                        ),
                      ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                // color: ColorsConstants.textGrayColorLightOne,
                color: Theme.of(context).colorScheme.surface,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: OptionComponent(
                optionTitle: "Manage Subscription",
                svgImage: ImagesConstants.crown,
                onTap: () {
                  if (AppHelper.checkUser()) {
                    Navigator.pushNamed(
                        context, "/manageSubscriptionScreen");
                  } else {
                    AppHelper.navigateToRegister(
                        context: context,
                        onUserFound: () {
                          Navigator.pushNamed(
                              context, "/manageSubscriptionScreen");
                        });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Theme.of(context).colorScheme.surface,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: OptionComponent(
                optionTitle: "Language",
                svgImage: ImagesConstants.language,
                onTap: () {
                  Navigator.pushNamed(context, "/languageScreen");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Theme.of(context).colorScheme.surface,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: OptionComponent(
                optionTitle: "Your News",

                svgImage: ImagesConstants.mice,
                onTap: () {
                  if (AppHelper.checkUser()) {
                    Navigator.pushNamed(context, "/yourNewsScreen");
                  } else {
                    AppHelper.navigateToRegister(
                        context: context,
                        onUserFound: () {
                          Navigator.pushNamed(context, "/yourNewsScreen");
                        });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Theme.of(context).colorScheme.surface,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: OptionComponent(
                optionTitle: "Support",
                svgImage: ImagesConstants.headPhone,
                onTap: () {
                  // Navigator.pushNamed(context,"/sessionExpired");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                color: Theme.of(context).colorScheme.surface,
                thickness: 1,
              ),
            ),
            // InkWellCustom(
            //     onTap: () {
            //       Navigator.pushNamed(context, "/subscriptionScreen");
            //     },
            //     child: Container(
            //       height: 50,
            //       width: 100,
            //       color: Colors.red,
            //     ))
          ],
        )),
      ),
    );
  }
}
