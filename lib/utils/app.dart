import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';
import 'package:newsapp/presentation/screens/bottom_navigator_screen.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:taboola_sdk/taboola.dart';

import '../constants/app_constant.dart';
import '../constants/colors_constants.dart';
import '../constants/common_model/api_model.dart';
import '../constants/common_model/key_value_model.dart';
import '../data/login_data/domain/login_model/login_model.dart';
import '../presentation/screens/popups/pop_ups_screen.dart';
import 'app_localization.dart';
import 'dark_theme_provider.dart';
import 'package:http/http.dart' as http;

class AppHelper {
  static String getDynamicString(BuildContext context, String text) {
    if (AppLocalizations.of(context) != null) {
      return AppLocalizations.of(context)!.translate(text);
    }
    return text;
  }

  static bool checkIsHindi() {
    return SessionHelper().get(SessionHelper.languageCode) == "hi";
  }


  static Future<void> clearSession(BuildContext context) async {
    String? allowNotification =
        SessionHelper().get(SessionHelper.allowNotification);
    String? languageCode = SessionHelper().get(SessionHelper.languageCode);
    String? fontSize = SessionHelper().get(SessionHelper.fontSize);
    String? firstTimeLogin = SessionHelper().get(SessionHelper.firstTimeLogin);
    String? imageBaseUrl = SessionHelper().get(SessionHelper.imageBaseUrl);
    SessionHelper().clear();
    await SessionHelper.getInstance(context);
    SessionHelper()
        .put(SessionHelper.allowNotification, allowNotification ?? "false");
    SessionHelper().put(SessionHelper.languageCode, languageCode ?? "hi");
    SessionHelper().put(SessionHelper.fontSize, fontSize ?? "medium");
    SessionHelper().put(SessionHelper.firstTimeLogin, firstTimeLogin ?? "true");
    if (imageBaseUrl != null) {
      SessionHelper().put(SessionHelper.imageBaseUrl, imageBaseUrl.toString());
    }
  }

  static String getHindiEnglishText(String? englishText, String? hindiText) {
    if (SessionHelper().get(SessionHelper.languageCode) == "hi") {
      return hindiText ?? englishText ?? "";
    }
    return englishText ?? "";
  }

  static int getFontSize() {
    String? temp = SessionHelper().get(SessionHelper.fontSize) ?? "";
    if (temp == "small") {
      return -4;
    } else if (temp == "large") {
      return 4;
    }
    return 0;
  }

  static String getDateFormatter(DateTime value) {
    return "${AppConstant.getDay(value.weekday)}, ${AppConstant.getMonth(value.month)},${value.day}, ${value.year}";
  }

  static String getUserName() {
    return SessionHelper().get(SessionHelper.name) ?? "";
  }

  static String getUserEmail() {
    return SessionHelper().get(SessionHelper.email) ?? "";
  }

  static void setUser(LoginModel model) {
    if(model.imageUrl != null){
      SessionHelper().put(SessionHelper.imageBaseUrl, model.imageUrl.toString());
    }

    if (model.tokens != null &&
        model.tokens!.access != null &&
        model.tokens!.refresh != null) {
      SessionHelper()
          .put(SessionHelper.userId, model.tokens!.access!.token ?? "");
    }
    if (model.tokens != null && model.tokens!.refresh != null) {
      SessionHelper()
          .put(SessionHelper.refreshToken, model.tokens!.refresh!.token ?? "");
    }

    if (model.user != null) {
      SessionHelper().put(SessionHelper.name, model.user!.name ?? "");
      SessionHelper().put(SessionHelper.email, model.user!.email ?? "");
      if (model.user!.userDetail != null) {
        SessionHelper().put(SessionHelper.profileStatus,
            (model.user!.userDetail!.profileStatus ?? 0).toString());
      }
      SessionHelper()
          .put(SessionHelper.profileImage, model.user!.profileImage ?? "");
    }
  }

  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static Future<void> navigateToHome(BuildContext context) async {
    SessionHelper sessionHelper = await SessionHelper.getInstance(context);
    sessionHelper.put(SessionHelper.firstTimeLogin, "true");
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
    }
  }

  static Future<void> navigateToRegister(
      {required BuildContext context, required Function onUserFound}) async {
    if (context.mounted && !AppHelper.checkUser()) {
      Navigator.pushNamed(context, "/login",
          arguments: {"checkBackButton": true}).then((value) {
        if (AppHelper.checkUser()) {
          onUserFound();
        }
      });
    }
  }

  static String months(int m) {
    List month = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return month[m];
  }

  static String dateChange(String time) {
    DateTime t = DateTime.parse(time);
    return "${t.day.toString()} ${months(t.month)} ${t.year.toString()}";
  }

  static String dateChange3(String time) {
    DateTime t = DateTime.parse(time);
    return DateFormat('hh:mm a').format(t);
  }

  static String dateChangeMinAndSec(String time) {
    DateTime t = DateTime.parse(time);
    return DateFormat('hh:mm a').format(t);
  }

  static String dateChange2(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  static void changeToHomeScreen(
      BuildContext context, TabController controller) {
    if (context.mounted) {
      controller.index = 0;
      currentIndex = 0;
    }
  }

  static String formatDurationInHhMmSs(Duration duration) {
    final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$mm:$ss';
  }

  static String htmlContent(String html, BuildContext context) {
    return '''<html lang="en"><body style="color : ${Provider.of<DarkThemeProvider>(context).darkTheme ? "white" : "black"}">$html</body></html>''';
  }

  static String htmlTrimString(String htmlContent) {
    final regex = RegExp(r'\s{2,}|\n(?!</?\w+>)');
    return htmlContent.replaceAll("&lt;", "<").replaceAll(regex, ' ');
  }

  static Color randomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(0.8);
  }

  static showSnakeBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style:
            TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 10,
    ));
  }

  static Future<void> convertImageToWebP(String imagePath) async {
    // var imageBytes = await FlutterImageCompress.compressWithFile(
    //   imagePath,
    //   format: CompressFormat.webp,
    // );
    // print("----------------- Image -------------");
    // print(imageBytes);
    // print("------------------------------");
    // Now you can use the imageBytes as needed, e.g., save it to a file or upload it to a server.
  }

  static bool checkIsWeb() {
    return kIsWeb;
  }

  static PopupMenuItem item(
      BuildContext context, String name, IconData i, String value) {
    return PopupMenuItem(
      textStyle:
          TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            i,
            color: Theme.of(context).textTheme.displayLarge!.color,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(name)
        ],
      ),
    );
  }

  static String timeAgo(DateTime d) {
    Duration diff = DateTime.now().toUtc().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  static void myPrint(Object? value) {
    if (kDebugMode) {
      dev.log(value.toString());
    }
  }


  static Future<Either<dynamic, ApiModel>> apiCall(
      {String apiType = "get",
      bool isJsonEncode = false,
      bool tokenRequired = true,
      String responseType = "object",
      required String url,
      required dynamic responseClass,
      Map? body}) async
  {
    try {
      http.Response? response;
      Map<String, String> headers = {};
      if (tokenRequired) {
        headers.addAll({
          'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}'
        });
      }
      if (isJsonEncode) {
        headers.addAll({"content-type": "application/json"});
      }

      Object? sendBody;

      if (body != null) {
        sendBody = isJsonEncode ? json.encode(body) : body;
      }

      if (apiType == "post") {
        response =
            await http.post(Uri.parse(url), body: sendBody, headers: headers);
      } else if (apiType == "put") {
        response =
            await http.put(Uri.parse(url), body: sendBody, headers: headers);
      } else if (apiType == "delete") {
        response =
            await http.delete(Uri.parse(url), body: sendBody, headers: headers);
      } else {
        response = await http.get(Uri.parse(url), headers: headers);
      }

      AppHelper.myPrint(
          "--------------------- Response Screen -----------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("--------------------------------------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        if (responseType == "object") {
          final details = jsonData as Map<String, dynamic>;
          return Left(responseClass.fromJson(details));
        } else {
          List<dynamic> list = [];
          final details = jsonData as List;
          details.map((e) => list.add(responseClass.fromJson(e))).toList();
          return Left(list);
        }
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> callApi(
      {String apiType = "get",
      bool isJsonEncode = false,
      bool tokenRequired = true,
      required String url,
      Map? body}) async {
    try {
      AppHelper.myPrint(
          "------------------ Token ------  Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)} -------------");

      http.Response? response;
      Map<String, String> headers = {};
      if (tokenRequired) {
        headers.addAll({
          'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}'
        });
      }
      if (isJsonEncode) {
        headers.addAll({"content-type": "application/json"});
      }

      Object? sendBody;

      if (body != null) {
        sendBody = isJsonEncode ? json.encode(body) : body;
      }

      if (apiType == "post") {
        response =
            await http.post(Uri.parse(url), body: sendBody, headers: headers);
      } else if (apiType == "put") {
        response =
            await http.put(Uri.parse(url), body: sendBody, headers: headers);
      } else if (apiType == "delete") {
        response =
            await http.delete(Uri.parse(url), body: sendBody, headers: headers);
      } else {
        response = await http.get(Uri.parse(url), headers: headers);
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> postApi(
      {required String url,
      required Map body,
      String? apiType,
      bool addHeader = true,
      List<KeyValueModel> fields = const []}) async {
    http.MultipartRequest api =
        http.MultipartRequest(apiType ?? 'POST', Uri.parse(url));

    if (addHeader) {
      api.headers.addAll({
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      });
    }

    if (body.isNotEmpty) {
      api.fields.addAll(body.map<String, String>(
          (key, value) => MapEntry(key, json.encode(value))));
    }

    for (int i = 0; i < fields.length; i++) {
      http.MultipartFile file = await http.MultipartFile.fromPath(
          fields[i].key, fields[i].value,
          filename: fields[i].fileName);
      api.files.add(file);
    }
    final streamedResponse = await api.send();
    return await http.Response.fromStream(streamedResponse);
  }

  static String getTotalReviews(int value) {
    return NumberFormat.compact(locale: 'en').format(value);
  }

  static String calculateTimeAgo(BuildContext context, DateTime time) {
    Duration diff = DateTime.now().toLocal().difference(time);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${AppHelper.getDynamicString(context, (diff.inDays / 365).floor() == 1 ? "year" : "years")} ${AppHelper.getDynamicString(context, "ago")}";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${AppHelper.getDynamicString(context, (diff.inDays / 30).floor() == 1 ? "month" : "months")} ${AppHelper.getDynamicString(context, "ago")}";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${AppHelper.getDynamicString(context, (diff.inDays / 7).floor() == 1 ? "week" : "weeks")} ${AppHelper.getDynamicString(context, "ago")}";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${AppHelper.getDynamicString(context, diff.inDays == 1 ? "day" : "days")} ${AppHelper.getDynamicString(context, "ago")}";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${AppHelper.getDynamicString(context, diff.inHours == 1 ? "hour" : "hours")} ${AppHelper.getDynamicString(context, "ago")}";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${AppHelper.getDynamicString(context, diff.inMinutes == 1 ? "minute" : "minutes")} ${AppHelper.getDynamicString(context, "ago")}";
    }
    return AppHelper.getDynamicString(context, "just now");
  }

  static bool checkUser() {
    return (SessionHelper().get(SessionHelper.userId) ?? "").trim().isNotEmpty;
  }

  static bool isValidUrl(String url, {bool createBaseUrl = true}) {
    Uri? uri = Uri.tryParse(createBaseUrl ? createImageBaseUrl(url) : url);
    return uri != null && uri.scheme.isNotEmpty && uri.hasAuthority;
  }

  static String createImageBaseUrl(String url) {
    return "${SessionHelper().get(SessionHelper.imageBaseUrl) ?? ""}$url";
  }

  static void checkNewDropDown(
      {required BuildContext context,
      required List<DropdownMenuItem<String>> list,
      required Function(String) onTap,
      required String title,
      required String? selected}) {
    if (list.length > 10) {
      AllPopUi.listView(
        selectedValue: selected,
        context: context,
        items: list,
        title: title,
        onTap: onTap,
      );
    } else {
      AllPopUi.showDropDownSheet(
        selectedValue: selected,
        context: context,
        items2: list,
        title: title,
        onTap: onTap,
      );
    }
  }

  static void bottomSheet(
      {required BuildContext context,
      required String title,
      required Widget bottom,
      required Widget center}) {
    bool check = true;
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SimpleText(
                        text: title,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        if (check) {
                          Navigator.pop(context);
                          check = false;
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: ColorsConstants.textGrayColorLightTwo,
                height: 1,
              ),
              const SizedBox(
                height: 0,
              ),
              center,
              const SizedBox(
                height: 0,
              ),
              Divider(
                color: ColorsConstants.textGrayColorLightTwo,
                height: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              bottom,
              const SizedBox(
                height: 10,
              )
              // Spacer(),
            ],
          ),
        );
      },
    );
  }




  static Future<bool> checkFileSize(File file, {int? fileSizeInMB}) async {
    final sizeInBytes = await file.length();
    return sizeInBytes <
        (fileSizeInMB ?? AppConstant.maxFileSize) * 1024 * 1024;
  }

  static void fileExceedSizeError(BuildContext context, String error) {
    AllPopUi.warning(context: context, title: error, showConfirm: false);
  }

  static String fileSizeError() {
    return "File Size Must be smaller than ${AppConstant.maxFileSize} MB";
    // return "${AppConstant.getDynamicString("File_Size_Must_Be_Smaller_Than")} ${AppConstant.maxFileSize}${AppConstant.getDynamicString("MB")}";
  }

  static void showUpButton(
      {required ScrollController scrollController,
      required bool showButton,
      required Function setState,
      required Function(bool) onChange}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState();
      if (scrollController.hasClients) {
        if (scrollController.position.pixels > 50 && !showButton) {
          onChange(true);
        } else if (scrollController.position.pixels < 20 && showButton) {
          onChange(false);
        }
      }
    });
  }
}

// Future<String> _extractTextFromImage(File imageFile) async {
//   try {
//     final TextDetector _textDetector = GoogleMlKit.vision.textDetector();
//     final inputImage = InputImage.fromFile(imageFile);
//     final RecognisedText recognisedText = await _textDetector.processImage(inputImage);
//     String extractedText = recognisedText.text;
//     return extractedText;
//   } catch (e) {
//     print('Error while extracting text: $e');
//     return "";
//   }
// }
// Future<String> extractTextFromImage(File imageFile) async {
//   final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
//   final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
//   final VisionText visionText = await textRecognizer.processImage(visionImage);
//
//   String extractedText = '';
//   for (TextBlock block in visionText.blocks) {
//     for (TextLine line in block.lines) {
//       extractedText += '${line.text}\n';
//     }
//   }
//
//   textRecognizer.close();
//   return extractedText;
// }
