import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/presentation/widgets/tick_box_component.dart';
import '../../../constants/colors_constants.dart';
import '../../../utils/app.dart';
import '../../widgets/elevated_button.dart';
import '../../widgets/ink_well_custom.dart';

void deleteConfirm(
    {required BuildContext context,
    required String title,
    required Function onDelete}) async {
  AllPopUi.warning(
      context: context,
      title: "Are you sure",
      subTitle: "You want to delete This $title",
      onPressed: (bool value) {
        onDelete();
      });
}

class AllPopUi {
  static void warning(
      {required BuildContext context,
      Function(bool)? onPressed,
      Function? onCancel,
      Widget widget = const SizedBox(),
      String title = "",
      bool showCancel = true,
      bool isShowLogout = false,
      bool barrierDismissible = true,
      bool showConfirm = true,
      String? confirmText,
      String? cancelText,
      String subTitle = ""}) async {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        bool allDeviceLogout = false;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return PopScope(
            canPop: barrierDismissible,
            child: AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              icon: barrierDismissible
                  ? Align(
                      alignment: Alignment.topRight,
                      child: InkWellCustom(
                          onTap: () {
                            if (onCancel != null) {
                              onCancel();
                            }
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close)))
                  : null,
              buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              elevation: 0,
              alignment: Alignment.center,
              scrollable: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Column(
                children: [
                  // SvgPicture.asset(ImagesConstants.notWell),
                  const SizedBox(
                    height: 10,
                  ),
                  if (title.isNotEmpty)
                    SimpleText(
                        text: title,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 18,
                        weight: FontWeight.w600),
                ],
              ),
              content: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 4,
                ),
                child: SingleChildScrollView(
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget,
                      const SizedBox(
                        height: 5,
                      ),
                      if (subTitle.isNotEmpty)
                        SimpleText(
                            text: subTitle,
                            color: ColorsConstants.descriptionColor),
                      const SizedBox(
                        height: 10,
                      ),
                      if (isShowLogout)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TickBox(
                                  isTicked: allDeviceLogout,
                                  onTap: (bool value) {
                                    allDeviceLogout = value;
                                    setState(() {});
                                  }),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(child: SimpleText(text: "Logout from all devices"))
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
              actions: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Row(
                    children: [
                      if (showCancel)
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: CustomElevatedButton(
                              buttonColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorsConstants.white),
                              onPressed: () {
                                if (onCancel != null) {
                                  onCancel();
                                }
                                Navigator.pop(context);
                              },
                              text: cancelText ?? "Cancel",
                            ),
                          ),
                        ),
                      if (showConfirm)
                        const SizedBox(
                          width: 20,
                        ),
                      if (showConfirm)
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: CustomElevatedButton(
                                buttonColor: ColorsConstants.appColor,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ColorsConstants.white),
                                text: confirmText ?? "Confirm",
                                onPressed: () {
                                  if (onPressed != null) {
                                    onPressed(allDeviceLogout);
                                  }
                                }),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  static void listView(
      {required BuildContext context,
      Function(bool)? onPressed,
      required String? selectedValue,
      Function? onCancel,
      required Function(String) onTap,
      String title = "",
      required List<DropdownMenuItem<String>> items,
      bool barrierDismissible = true}) async {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              alignment: Alignment.centerLeft,
              backgroundColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18.0))),
              content: Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .60,
                ),
                child: SingleChildScrollView(
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < items.length; i++)
                        Container(
                          decoration: BoxDecoration(
                              color: items[i].value == selectedValue
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer
                              // ? ColorsConstants.backgroundColor
                              // : ColorsConstants.white
                              ),
                          width: MediaQuery.of(context).size.width,
                          child: InkWellCustom(
                              onTap: () {
                                if (items[i].enabled) {
                                  onTap(items[i].value ?? "");
                                  Navigator.pop(context);
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: items[i].child,
                                        )),
                                        TickBox(
                                            isTicked:
                                                items[i].value == selectedValue,
                                            borderRadius: 20,
                                            onTap: (bool value) {
                                              if (items[i].enabled) {
                                                onTap(items[i].value ?? "");
                                                Navigator.pop(context);
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                  if ((items.length - 1) > i)
                                    Container(
                                      height: 1.5,
                                      color:
                                          ColorsConstants.textGrayColorLightTwo,
                                      width: MediaQuery.of(context).size.width,
                                    )
                                  // Divider(color: ColorsConstants.textFieldColor)
                                ],
                              )),
                        )
                    ],
                  ),
                ),
              ));
        });
      },
    );
  }

  static void showDropDownSheet(
      {required BuildContext context,
      required List<DropdownMenuItem<String>> items2,
      required String? selectedValue,
      required Function(String) onTap,
      String title = "",
      onContinue}) {
    AppHelper.bottomSheet(
        context: context,
        title: title,
        bottom: const SizedBox(),
        center: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
              padding: EdgeInsets.zero,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 1.7),
              child: items2.isNotEmpty
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < items2.length; i++)
                            Container(
                              decoration: BoxDecoration(
                                  color: items2[i].value == selectedValue
                                      ? Theme.of(context).colorScheme.onSurface
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                              width: MediaQuery.of(context).size.width,
                              child: InkWellCustom(
                                  onTap: () {
                                    if (items2[i].enabled) {
                                      onTap(items2[i].value ?? "");
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: items2[i].child)),
                                            TickBox(
                                                isTicked: items2[i].value ==
                                                    selectedValue,
                                                borderRadius: 20,
                                                onTap: (bool value) {
                                                  if (items2[i].enabled) {
                                                    onTap(
                                                        items2[i].value ?? "");
                                                    Navigator.pop(context);
                                                  }
                                                })
                                          ],
                                        ),
                                      ),
                                      if ((items2.length - 1) > i)
                                        Container(
                                          height: 1.5,
                                          // color:Theme.of(context).colorScheme.surface,
                                          color: ColorsConstants
                                              .textGrayColorLightTwo,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        )
                                      // Divider(
                                      //     color: ColorsConstants.textFieldColor)
                                    ],
                                  )),
                            )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SimpleText(
                        text: "No List Found",
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500),
                      ),
                    ));
        }));
  }
}
