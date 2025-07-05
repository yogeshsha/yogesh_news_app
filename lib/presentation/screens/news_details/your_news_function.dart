import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/app_constant.dart';
import '../../../constants/colors_constants.dart';
import '../../../constants/images_constants.dart';
import '../../../data/category_data/domain/report_reason_model.dart';
import '../../../utils/app.dart';
import '../../../utils/image_picker.dart';
import '../../widgets/primary_button_component.dart';
import '../../widgets/select_topic_container.dart';
import '../../widgets/share_chat_component.dart';
import '../../widgets/simple_text.dart';
import '../../widgets/text_common.dart';
import '../../widgets/text_form_field.dart';

class YourNewsFunction {
  static Future<double> getFileSizeInMB(XFile file) async {
    return (await file.length()) / (1024 * 1024);
  }

  static String getFileName(Either<XFile, String> file) {
    if (file.isLeft) {
      return file.left.path.split("/").last;
    } else {
      return file.right.split("/").last;
    }
  }

  static Future<String> getFileSize(Either<XFile, String> file) async {
    if (file.isLeft) {
      return (await getFileSizeInMB(file.left)).toStringAsFixed(1);
    } else {
      return "";
    }
  }

  static void onTapShare(
      {required BuildContext context, required Function(XFile) onSelectFile}) {
    AppConstant.hideKeyBoard;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 40),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShareChatComponent(
                        backGroundColor: ColorsConstants.amountGreenColor,
                        image: ImagesConstants.shareGallery,
                        name: "Photos",
                        onTap: () {
                          Picker.showImagePicker(
                              x: MediaQuery.of(context).size.width,
                              y: MediaQuery.of(context).size.width / 2,
                              context, (XFile? file) {
                            if (file != null) {
                              Navigator.pop(context);
                              onSelectFile(file);
                            }
                          });
                        }),
                    const SizedBox(width: 20),
                    ShareChatComponent(
                        backGroundColor: ColorsConstants.shareVideoColor,
                        image: ImagesConstants.shareVideo,
                        name: "Videos",
                        onTap: () {
                          Picker.showVideoPicker(context, (file) {
                            if (file != null) {
                              Navigator.pop(context);
                              onSelectFile(file);
                            }
                          });
                        }),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showReportBottomSheet(BuildContext context,
      List<Reasons> reasonList, Function(String reason) onTapReport) {
    double mediaHeight = MediaQuery.of(context).size.height;
    int isSelect = -1;
    String reason = "";
    String otherTitle = "Other";
    bool check = false;
    TextEditingController descriptionController = TextEditingController();

    AppHelper.bottomSheet(
        context: context,
        title: "Report The Post",
        bottom: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                      height: 50,
                      child: PrimaryButtonComponent(
                          margin: EdgeInsets.zero,
                          title: "Report this post",
                          onTap: () {
                            if (reason.isNotEmpty) {
                              onTapReport(reason);
                              Navigator.pop(context);
                            } else {
                              AppHelper.showSnakeBar(context, "Select Reason");
                            }
                          })),
                ),
              ],
            ),
          ),
        ),
        center: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 10),
            constraints: BoxConstraints(
                maxHeight: mediaHeight -
                    200 -
                    MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SimpleText(
                    text: "why are you reporting this post?",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  // ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextAll(
                            text: "Select Reason",
                            weight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                            max: 14),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: reasonList.length,
                            shrinkWrap: true,
                            itemBuilder:
                                (BuildContext context, int index) {
                              Reasons list = reasonList[index];
                              return Column(
                                children: [
                                  SelectTopicContainer(
                                      title: list.title ?? "",
                                      isSelect: isSelect == index,
                                      onSelect: () {
                                        isSelect = index;
                                        check = false;
                                        reason = list.title ?? "";
                                        setState(() {});
                                      }),
                                ],
                              );
                            }),
                        SelectTopicContainer(
                            title: "Other",
                            isSelect: check,
                            onSelect: () {
                              check = true;
                              // reason = "Other";
                              setState(() {});
                            }),
                        if (check)
                          TextFormFieldWidget(
                              margin: const EdgeInsets.only(
                                  bottom: 10, top: 5),
                              borderCurve: 10,
                              hint: "Describe the problem...",
                              maxLength: 1000,
                              maxLines: 6,
                              controller: descriptionController,
                              validation: (value) {
                                reason = descriptionController.text
                                    .trim()
                                    .toString();
                                return null;
                              }),

                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
