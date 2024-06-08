import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_size.dart';
import 'color_constant.dart';

class TextStyleConstant {
  static const TextStyle kTitleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: AppSizes.s22,
    color: ColorConstants.kWhiteColor,
  );
  static const TextStyle kTitleSmallTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: ColorConstants.kWhiteColor,
  );

  static const TextStyle kSubTitleTextStyle = TextStyle(
    color: ColorConstants.kWhiteColor,
    fontSize: AppSizes.s14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle kYellowTitleTextStyle = TextStyle(
    color: ColorConstants.kYellowColor,
    fontSize: AppSizes.s22,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle kSmallSubTitleTextStyle = TextStyle(
    color: ColorConstants.kGreyColor,
    fontSize: AppSizes.s12,
    fontWeight: FontWeight.w500,
  );
}

ThemeData darkThemeData = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(
        0xFFE00E33,
        {
          50: Color(0xFFE00E33),
          100: Color(0xFFE00E33),
          200: Color(0xFFE00E33),
          300: Color(0xFFE00E33),
          400: Color(0xFFE00E33),
          500: Color(0xFFE00E33),
          600: Color(0xFFE00E33),
          700: Color(0xFFE00E33),
          800: Color(0xFFE00E33),
          900: Color(0xFFE00E33),
        },
      ),
      backgroundColor: ColorConstants.kBackgroundColor,
    ),
    scaffoldBackgroundColor: ColorConstants.kBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.kBackgroundColor,
      elevation: 0,
      foregroundColor: ColorConstants.kWhiteColor,
    ),
    textTheme: GoogleFonts.battambangTextTheme());
