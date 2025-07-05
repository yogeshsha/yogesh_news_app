import 'package:flutter/material.dart';
import 'package:newsapp/presentation/screens/language/component/language_component.dart';
import 'package:newsapp/presentation/widgets/tick_box_component.dart';
import 'package:newsapp/utils/language.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constant.dart';
import '../../../constants/common_model/language_model.dart';
import '../setting/component/common_app_bar_component.dart';
import '../sign_in_screen/component/bottom_button_component.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String languageCode = "";

  List<LanguageModel> languageList = [];
  AppLanguage appLanguage = AppLanguage();

  @override
  void initState() {
    setData();
    super.initState();
  }

  void setData() {
    languageList.add(LanguageModel(value: "en", title: "English"));
    languageList.add(LanguageModel(value: "hi", title: "हिंदी"));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appLanguage = Provider.of<AppLanguage>(context, listen: false);

      setState(() {
        languageCode = appLanguage.appLocal.languageCode;
      });
    });
  }

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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: CommonAppBarComponent(
                      title: "Language",
                    ),
                  ),
                  // arrowBack2(context),
                  // const SizedBox(height: 40),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: mediaWidth * 0.04),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: mediaWidth * 0.05,
                      spacing: mediaWidth * 0.05,
                      children: languageList
                          .map((e) => Stack(
                                children: [
                                  LanguageComponent(
                                      title: e.title,
                                      onTap: () {
                                        languageCode = e.value;
                                        setState(() {});
                                      },
                                      isTicked: languageCode == e.value),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: TickBox(
                                        isTicked: languageCode == e.value,
                                        onTap: (bool value) {
                                          languageCode = e.value;
                                          setState(() {});
                                        }),
                                  )
                                ],
                              ))
                          .toList(),
                    ),
                  )
                ],
              ),
              if (languageCode != appLanguage.appLocal.languageCode)
                BottomButtonComponent(onTapLeft: () {
                  Navigator.pop(context);
                }, onTapRight: () {
                  appLanguage.changeLanguage(Locale(languageCode));
                  SessionHelper().put(SessionHelper.languageCode, languageCode);

                  Navigator.pop(context);
                })
            ],
          ),
        ),
      ),
    );
  }
}
