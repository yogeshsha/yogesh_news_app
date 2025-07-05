import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorsConstants {
  static Color arrowColor = Colors.white10;
  static Color boxColor = const Color(0xffF5C848);
  static Color logoColor = const Color(0xffEEEE58);
  static Color drawerDividerColor = const Color(0xff222222);
  static Color shimmerColor1 = const Color(0xffC0C0C0);
  static Color shimmerColor2 = const Color(0xffFFFFFF);
  static Color heartColor = Colors.brown;

  //New Changes
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color appColor = const Color(0xFF6E53F1);
  static Color textGrayColor = const Color(0xFF808080);
  static Color textGrayColorLightTwo = textGrayColor.withOpacity(.3);
  static Color textGrayColorLightOne = textGrayColor.withOpacity(.1);
  static Color textGrayColorLightThree = textGrayColor.withOpacity(.5);
  static Color skipColor = const Color(0xff777777);
  static Color textFieldColor = const Color(0xffE5E5E5);
  static Color faceBookColor = const Color(0xff3C5A99);
  static Color skyBlue = const Color(0xff007FF4);
  static Color unSelect = const Color(0xffC7C7C7);
  static Color lightAppColor = const Color(0xffBBB2E7);
  static Color amountGreenColor = const Color(0xFF00B383);
  static Color shareVideoColor = const Color(0xFF649AF3);
  static Color backGroundFloatingColor = const Color(0x591D1D1D);
  static Color filterBackgroundColor = const Color(0xFF777777);
  static Color errorColor = const Color(0xffD65745);

  //BottomNav
  static Color arrowBackColor = const Color(0xFFF2F2F2);
  static Color searchBackGroundDarkColor = const Color(0xFF3E3E3E);
  static Color subTitleHomeColor = const Color(0xFF989898);
  static Color dividerDarkColor = const Color(0xFF2C2C2C);

  // Settings
  static Color titleColor = const Color(0xFF292929);
  static Color subTitleColor = const Color(0xFF606060);
  static Color dividerColor = const Color(0xFFD9D9D9);
  static Color arrowColorSetting = const Color(0xFF8B8B8B);

  //Image Builder
  static Color backgroundColor = const Color(0xFFFEF0E6);

  //Featured Card
  static Color descriptionColor = const Color(0xFFA1A1A1);

  //Category UI
  static Color borderColor = const Color(0xFFD8D8D8);

  //News Card
  static Color newsCardBackgroundColor = const Color(0xFFF8F8F8);
  static Color subtitleColor = const Color(0xFF7C7C7C);
  static Color subtitleDarkModeColor = const Color(0xFFCACACA);
  static Color dotsColor = const Color(0xFF6A6A6A);


  //Notification
  static Color clearAllColor = const Color(0xFF737373);

}

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: isDarkTheme ? ColorsConstants.black : ColorsConstants.white,
      secondaryHeaderColor:
          isDarkTheme ? ColorsConstants.white : ColorsConstants.appColor,
      cardColor: isDarkTheme ? const Color(0xff3A3A3A) : Colors.white,
      colorScheme: getColors(isDarkTheme),
      iconTheme: IconThemeData(
          color: isDarkTheme
              ? ColorsConstants.subtitleDarkModeColor
              : ColorsConstants.titleColor),
      textTheme: TextTheme(
        titleSmall: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDarkTheme
                ? ColorsConstants.white
                : ColorsConstants.titleColor),
        bodySmall: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: isDarkTheme
                ? ColorsConstants.subTitleHomeColor
                : ColorsConstants.subtitleColor),
        displayLarge: GoogleFonts.poppins(
            color: isDarkTheme ? Colors.white : Colors.black),
        displayMedium: GoogleFonts.poppins(
            color: isDarkTheme ? const Color(0xffFDFDFD) : Colors.black),
        displaySmall: GoogleFonts.poppins(
            color: isDarkTheme ? Colors.white60 : Colors.black),
        bodyLarge: GoogleFonts.poppins(
            color: isDarkTheme ? Colors.black12 : Colors.grey[100]),
      ),
    );
  }

  static ColorScheme getColors(bool value) {
    if (value) {
      return ColorScheme.dark(
        primary: ColorsConstants.white,
        onPrimaryContainer: ColorsConstants.titleColor,
        onBackground: ColorsConstants.titleColor,
        onPrimary: ColorsConstants.white,
        onSecondary: ColorsConstants.subtitleDarkModeColor,
        secondary: ColorsConstants.white,
        background: ColorsConstants.searchBackGroundDarkColor,
        secondaryContainer: ColorsConstants.searchBackGroundDarkColor,
        onSecondaryContainer: ColorsConstants.searchBackGroundDarkColor,
        onSurface: ColorsConstants.searchBackGroundDarkColor,
        surface: ColorsConstants.dividerDarkColor,
        onSurfaceVariant: ColorsConstants.searchBackGroundDarkColor,
        primaryContainer: ColorsConstants.white,
        onTertiaryContainer: ColorsConstants.white,
        onTertiary: ColorsConstants.appColor,
      );
    }
    return ColorScheme.light(
      primary: ColorsConstants.black,
      onPrimaryContainer: ColorsConstants.white,
      onBackground: ColorsConstants.arrowBackColor,
      onPrimary: ColorsConstants.black,
      onSecondary: ColorsConstants.subTitleColor,
      secondary: ColorsConstants.titleColor,
      background: ColorsConstants.appColor,
      secondaryContainer: ColorsConstants.unSelect,
      onSecondaryContainer: ColorsConstants.white,
      onSurface: ColorsConstants.borderColor,
      surface: ColorsConstants.dividerColor,
      onSurfaceVariant: ColorsConstants.newsCardBackgroundColor,
      primaryContainer: ColorsConstants.textFieldColor,
      onTertiaryContainer: ColorsConstants.textGrayColor,
      onTertiary: ColorsConstants.white,
    );
  }
}
