import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/utils/app.dart';

import '../constants/app_constant.dart';

class DateFormatter{

  static String getTodayDayMonthYear(BuildContext context,DateTime value) {
    return "${AppHelper.getDynamicString(context,AppConstant.getDay(value.weekday))},${AppHelper.getDynamicString(context,AppConstant.getMonth(value.month))} ${value.day},${value.year}";
  }

  static String getMonthAndYear(DateTime value) {
    return "${AppConstant.getMonth(value.month)},${value.year}";
  }

  static String getDateFormatter(DateTime value) {
    return "${value.day} ${AppConstant.getMonth(value.month)} ${value.year}";
  }

  static String getDateFormatter4(DateTime value) {
    return "${value.day} ${AppConstant.getShortMonth(value.month)} ${value.year}";
  }

  static String getDateFormatter1(DateTime value) {
    return "${AppConstant.getShortMonth(value.month)} ${value.year}";
  }

  static String getDateFormatter10(DateTime value) {
    return "${value.day} ${AppConstant.getShortMonth(value.month)},${value.year}";
  }

  static String getDateFormatter8(DateTime value) {
    return "${value.day} ${AppConstant.getShortMonth(value.month)}";
  }

  static String getDateFormatter2(DateTime value) {
    return "${value.day} ${AppConstant.getMonth(value.month)}";
  }

  static String getDateFormatter11(DateTime value) {
    return "${value.month}/${(value.year % 100)}";
  }

  static String getDateFormatter3(DateTime value) {
    return DateFormat("hh:mm aaa").format(value);
  }

  static String getDateFormatter5(DateTime value) {
    return DateFormat("hh:mm:ss").format(value);
  }

  static String getDateFormatter7(DateTime value) {
    return DateFormat("HH:mm:ss").format(value);
  }

  static String getDateFormatter6(DateTime value) {
    return DateFormat("yyyy-MM-dd").format(value);
  }

  static String getDateFormatterCurrentDate(DateTime value) {
    return DateFormat("dd-MM-yyyy").format(value);
  }

  static String getDateFormatterCurrentDate1(DateTime value) {
    return DateFormat("dd/MM/yyyy").format(value);
  }





  static String getDateHourMinute(DateTime value) {
    return DateFormat("hh:mm").format(value);
  }

  static String getDateAmPm(DateTime value) {
    return DateFormat("aaa").format(value);
  }

}