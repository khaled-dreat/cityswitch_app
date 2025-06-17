import 'package:flutter/material.dart';

/// A centralized class to hold all color constants used in the app.
/// Prevents instantiation using private constructor.
class AppColors {
  AppColors._();

  // White and Black shades
  static const Color white = Color(0xFFFFFFFF); // pure white
  static const Color black = Color(0xFF000000); // pure black
  static const Color black25 = Color.fromRGBO(
    0,
    0,
    0,
    0.25,
  ); // 25% opacity black

  // Grey scale colors
  static const Color grey100 = Color(0xFFD9D9D9);
  static const Color grey200 = Color(0xFFEBEBEB);
  static const Color grey300 = Color(0xFFEEEEEE);
  static const Color grey400 = Color(0xFF545050);
  static const Color grey500 = Color(0xFF858080);
  static const Color grey600 = Color(0xFF6D6E71);
  static const Color grey700 = Color(0xFF808080);
  static const Color grey800 = Color(0xFF828282);
  static const Color grey900 = Color(0xFFACACAC);
  static const Color greyA = Color(0xFFBABABA);
  static const Color greyB = Color(0xFFF4F4F4);
  static const Color greyC = Color(0xFFF6F6F6);

  // Green tones
  static const Color greenDark = Color(0xFF045210); // deep green
  static const Color greenDark70 = Color.fromRGBO(
    4,
    82,
    16,
    0.7,
  ); // 70% opacity
  static const Color greenDark30 = Color.fromRGBO(
    4,
    82,
    16,
    0.3,
  ); // 30% opacity

  static const Color greenBright = Color(0xFF37BB4B); // bright green
  static const Color greenBright60 = Color.fromRGBO(
    55,
    187,
    75,
    0.6,
  ); // 60% opacity
  static const Color greenBright50 = Color.fromRGBO(
    55,
    187,
    75,
    0.5,
  ); // 50% opacity

  static const Color greenLight = Color(0xFFBAF8C3); // light green
  static const Color greenLighter = Color(0xFFE9FFED); // very light green
  static const Color greenPalest = Color(0xFFC5FFCE); // palest green

  // Accent colors
  static const Color yellowBright = Color(0xFFFFCD29); // bright yellow
  static const Color orangeDark = Color(0xFFCF6B00); // dark orange

  static const Color purpleDeep = Color(0xFF1B0044); // deep purple
  static const Color purpleBright = Color(0xFF9747FF); // bright purple

  static const Color blueDarkish = Color(0xFF1F2937); // darkish blue
  static const Color blueMid = Color(0xFF376EBB); // mid-tone blue
}
