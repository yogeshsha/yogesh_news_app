import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';



class AppColor {
  static Color backGroundColor = const Color(0xFFFAFAFB);
  static Color primaryColor = Colors.blueAccent;
  static Color textGrey = const Color(0xFF858C9F);
  static Color button = const Color(0xFF139AD9);
  static Color price = const Color(0xFFFF113C);
  static Color arrow = const Color(0xFF071331);
  static Color field = const Color(0xFFECF1F9);
  static Color line = const Color(0xFFDCE0EC);
  static Color back = const Color(0xFFD9DBE1);
}


class AppConstant {

  // static String dummyImage = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkR48LoFHBZXunbYp-PlllTPPEgrgml-paqg&s";

  static List<String> imageExtension = ["png","jpg","svg","jpeg"];
  static List<String> videoExtension = ["mp4","mkv","webm"];

  static ColorFilter getColorFilter(Color color) {
    return ColorFilter.mode(color, BlendMode.srcIn);
  }

  static bool checkConnectionTimeOut(String errorMessage) {
    return ((errorMessage == "Connection timed out") ||
        (errorMessage == "Failed host lookup: '${ApiConstants.ip}'"));
  }

  static Duration deBouncerDuration = const Duration(milliseconds: 500);
  static int maxFileSize = 10;

  static int paginationLimit = 25;
  static int reviewsPaginationLimit = 5;
  static String rupeesSymbol = "₹";

  static String apiKey = ""; //Add Your Key


  static String clientSecret = ""; //Add Your Key
  static String deepLinkUrl = "https://newsApp.com/";

  static TextInputFormatter numberFormatter =
  FilteringTextInputFormatter.allow(RegExp("[0-9.]"));
  static TextInputFormatter numberFormatterWithoutDot =
  FilteringTextInputFormatter.allow(RegExp("[0-9]"));
  static TextInputFormatter rejectCharacter =
  FilteringTextInputFormatter.deny(RegExp("[@#\$%&<>]"));
  static TextInputFormatter nameFormatter =
  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"));
  static TextInputFormatter denyAndOperator =
  FilteringTextInputFormatter.deny(RegExp(r'&'));

  static TextInputFormatter nameFormatterWithUnderScore =
  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9_-]"));
  static TextInputFormatter nameFormatterWithSpace =
  // FilteringTextInputFormatter.allow(RegExp(r"^[a-z][a-z0-9+.-]*$"));
  // FilteringTextInputFormatter.allow(RegExp(r"^(?:\p{L}\p{Mn}*|\p{N}|\s)+$", unicode: true));
  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"));
  static TextInputFormatter emailFormatter =
  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.]"));
  static TextInputFormatter nameFormatterWithDot =
  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z. ]"));
  static TextInputFormatter nameFormatterWithNumber =
  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"));
  static TextInputFormatter nameFormatterWithNumberInUpperCase =
  FilteringTextInputFormatter.allow(RegExp("[A-Z0-9]"));
  static TextInputFormatter nameFormatterWithNumberAndSpace =
  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]"));
  static int expireDays = 90;
  static int importContactValue = 77;
  static Future<dynamic> hideKeyBoard =
  SystemChannels.textInput.invokeMethod('TextInput.hide');




  static DateTime bookingHourTimeStart = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 6, 0, 0);
  static DateTime bookingHourTimeEnd = DateTime(DateTime.now().year,
      DateTime.now().month, DateTime.now().day, 23, 59, 59);



  static List<DateTime> getDaysInBetween() {
    DateTime startDate = DateTime.now().copyWith(hour: 8, minute: 0, second: 0);
    DateTime endDate = DateTime.now().copyWith(hour: 23, minute: 0, second: 0);

    List<DateTime> days = [];
    DateTime temp = startDate;
    for (int i = 0; i <= (endDate.difference(startDate).inHours) * 2; i++) {
      days.add(temp.add(const Duration(minutes: 30)));
      temp = temp.add(const Duration(minutes: 30));
    }
    return days;
  }

  static List<DateTime> getHoursInBetween(
      DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    DateTime temp = DateTime(
        startDate.year, startDate.month, startDate.day, startDate.hour);
    DateTime tempEndDate =
    DateTime(endDate.year, endDate.month, endDate.day, endDate.hour, 1, 1);
    while (temp.isBefore(tempEndDate)) {
      days.add(temp);
      temp = temp.add(const Duration(hours: 1));
    }
    return days;
  }

  static List<int> getMinutes(DateTime startDate, DateTime endDate) {
    List<int> minutes = [];
    if (startDate.day == endDate.day && startDate.hour == endDate.hour) {
      for (int i = startDate.minute; i < endDate.minute + 1; i++) {
        minutes.add(i);
      }
    } else {
      for (int i = startDate.minute; i < 60; i++) {
        minutes.add(i);
      }
    }

    return minutes;
  }


  static Iterable<TimeOfDay> getTimeSlots(
      TimeOfDay startTime, TimeOfDay endTime, Duration interval) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += interval.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  static String getShortDay(int value) {
    switch (value) {
      case 0:
        {
          return "Sun";
        }
      case 1:
        {
          return "Mon";
        }
      case 2:
        {
          return "Tue";
        }
      case 3:
        {
          return "Wed";
        }
      case 4:
        {
          return "Thu";
        }
      case 5:
        {
          return "Fri";
        }
      case 6:
        {
          return "Sat";
        }
      case 7:
        {
          return "Sun";
        }
      default:
        {
          return "";
        }
    }
  }

  static String getVeryShortDay(int value) {
    switch (value) {
      case 0:
        {
          return "Su";
        }
      case 1:
        {
          return "Mo";
        }
      case 2:
        {
          return "Tu";
        }
      case 3:
        {
          return "We";
        }
      case 4:
        {
          return "Th";
        }
      case 5:
        {
          return "Fr";
        }
      case 6:
        {
          return "Sa";
        }
      case 7:
        {
          return "Su";
        }
      default:
        {
          return "";
        }
    }
  }

  static String getDay(int value) {
    switch (value) {
      case 0:
        {
          return "Sunday";
        }
      case 1:
        {
          return "Monday";
        }
      case 2:
        {
          return "Tuesday";
        }
      case 3:
        {
          return "Wednesday";
        }
      case 4:
        {
          return "Thursday";
        }
      case 5:
        {
          return "Friday";
        }
      case 6:
        {
          return "Saturday";
        }
      default:
        {
          return "";
        }
    }
  }




  static String getMonth(int value) {
    switch (value) {
      case 1:
        {
          return "January";
        }
      case 2:
        {
          return "February";
        }
      case 3:
        {
          return "March";
        }
      case 4:
        {
          return "April";
        }
      case 5:
        {
          return "May";
        }
      case 6:
        {
          return "June";
        }
      case 7:
        {
          return "July";
        }
      case 8:
        {
          return "August";
        }
      case 9:
        {
          return "September";
        }
      case 10:
        {
          return "October";
        }
      case 11:
        {
          return "November";
        }
      case 12:
        {
          return "December";
        }
      default:
        {
          return "";
        }
    }
  }

  static String getShortMonth(int value) {
    switch (value) {
      case 1:
        {
          return "Jan";
        }
      case 2:
        {
          return "Feb";
        }
      case 3:
        {
          return "Mar";
        }
      case 4:
        {
          return "Apr";
        }
      case 5:
        {
          return "May";
        }
      case 6:
        {
          return "Jun";
        }
      case 7:
        {
          return "Jul";
        }
      case 8:
        {
          return "Aug";
        }
      case 9:
        {
          return "Sep";
        }
      case 10:
        {
          return "Oct";
        }
      case 11:
        {
          return "Nov";
        }
      case 12:
        {
          return "Dec";
        }
      default:
        {
          return "";
        }
    }
  }






  static String getGoogleSearchAddressUrl(String lat, String long) {
    return "https://www.google.com/maps/search/?api=1&query=$lat,$long";
  }


  static String errorMessage(String message) {
    try {
      Map map = jsonDecode(message);
      if (map["message"] != null) {
        return map['message'];
      } else {
        return message;
      }
    } catch (e) {
      return message;
    }
  }
}


class SessionHelper {
  static late SharedPreferences sharedPreferences;
  static late SessionHelper _sessionHelper;
  static String allowNotification = "ALLOW_NOTIFICATION";
  static String languageCode = "LANGUAGE_CODE";
  static String fontSize = "FONT_SIZE";
  static String firstTimeLogin = "First_Time_Login";
  static String userId = "USER_ID";
  static String name = "NAME";
  static String imageBaseUrl = "IMAGE_BASE_URL";
  static String profileImage = "PROFILE_IMAGE";
  static String email = "EMAIL";
  static String profileStatus = "PROFILE_STATUS";
  static String isShowAds = "true";
  static String refreshToken = "REFRESH_TOKEN";

  static Future<SessionHelper> getInstance(BuildContext context) async {
    _sessionHelper = SessionHelper();
    sharedPreferences = await SharedPreferences.getInstance();
    return _sessionHelper;
  }

  String? get(String key) {
    return sharedPreferences.getString(key);
  }

  put(var key, var value) {
    sharedPreferences.setString(key, value);
  }

  clear() {
    sharedPreferences.clear();
  }

  remove(String key) {
    sharedPreferences.remove(key);
  }
}
class SessionHelperForVideo {
  static late SharedPreferences sharedPreferences;
  static late SessionHelperForVideo _sessionHelper;
  static String isMuted = "0";
  static String isPlaying = "true";
  static Future<SessionHelperForVideo> getInstance(BuildContext context) async {
    _sessionHelper = SessionHelperForVideo();
    sharedPreferences = await SharedPreferences.getInstance();
    return _sessionHelper;
  }

  String? get(String key) {
    return sharedPreferences.getString(key);
  }

  put(var key, var value) {
    sharedPreferences.setString(key, value);
  }

  clear() {
    sharedPreferences.clear();
  }

  remove(String key) {
    sharedPreferences.remove(key);
  }
}
