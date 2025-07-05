import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:newsapp/presentation/widgets/arrow_back_ios.dart';
import '../../../constants/app_constant.dart';
import '../../../constants/colors_constants.dart';
import '../../../utils/app.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/ink_well_custom.dart';
import '../../widgets/text_common.dart';

class TextEditorComponent extends StatefulWidget {
  final String title;
  final String value;
  final Function(String) onChange;

  const TextEditorComponent(
      {super.key,
      required this.title,
      required this.value,
      required this.onChange});

  @override
  State<TextEditorComponent> createState() => _TextEditorComponentState();
}

class _TextEditorComponentState extends State<TextEditorComponent> {
  HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorsConstants.appColor,
        body: InkWellCustom(
            onTap: () => AppHelper.hideKeyboard(),
            child: SafeArea(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(children: [
                      // AppHelper.backGroundImage(),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const ArrowBackButton2(),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextAll(
                                        align: TextAlign.start,
                                        textDynamic: true,
                                        text:
                                            " ${widget.title}",
                                        weight: FontWeight.w700,
                                        color: Colors.white,
                                        max: 23),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                margin: const EdgeInsets.only(top: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Scrollable(
                                        viewportBuilder: (BuildContext context,
                                                position) =>
                                            HtmlEditor(
                                                controller: controller,
                                                htmlEditorOptions:
                                                    HtmlEditorOptions(
                                                  hint:
                                                      '${"Your_Text_Here"}...',
                                                  initialText: widget.value,
                                                ),
                                                htmlToolbarOptions:
                                                    HtmlToolbarOptions(
                                                        toolbarPosition:
                                                            ToolbarPosition
                                                                .belowEditor,
                                                        initiallyExpanded: true,
                                                        toolbarType: ToolbarType
                                                            .nativeScrollable,
                                                        buttonBorderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                otherOptions:
                                                    OtherOptions(
                                                        height:MediaQuery.of(context).size.height - 250))
                                      ),
                                    ),
                                    const SizedBox(height: 100)
                                  ],
                                ),
                              ),
                            )
                          ]),
                      BottomContainerWithShadow(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                width: 30,
                                child: CustomElevatedButton2(
                                    padding: EdgeInsets.zero,
                                    textColor: Colors.white,
                                    backgroundColor:ColorsConstants.appColor,
                                    text: "Save_Changes",
                                    onPressed: () async {
                                      String html = await controller.getText();
                                      if (html.contains('src="data:')) {
                                        if (context.mounted) {
                                          AppHelper.showSnakeBar(
                                              context, AppConstant.errorMessage("Something_Went_Wrong"));
                                        }
                                        return;
                                      }
                                      String temp =
                                          html.replaceAll("&nbsp;", "");
                                      if (temp.trim().isEmpty) {
                                        html = temp;
                                      }
                                      if (context.mounted) {
                                        AppHelper.myPrint("---------- Html ----------");
                                        AppHelper.myPrint(html);
                                        AppHelper.myPrint("--------------------");

                                        widget.onChange(html);

                                        Navigator.pop(context);
                                      }
                                    }),
                              ),
                            ),
                          ])),
                    ])))));
  }
}
