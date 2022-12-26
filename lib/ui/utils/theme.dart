import 'package:flutter/material.dart';

MaterialColor colorFromHex(int hexColor) {
  return MaterialColor(
    hexColor,
    <int, Color>{
      50: Color(hexColor),
      100: Color(hexColor),
      200: Color(hexColor),
      300: Color(hexColor),
      400: Color(hexColor),
      500: Color(hexColor),
      600: Color(hexColor),
      700: Color(hexColor),
      800: Color(hexColor),
      900: Color(hexColor),
    },
  );
}

final mainTheme = ThemeData(
  primarySwatch: colorFromHex(0XFFFF6100),
);

class ThemeColors  {
  static final MaterialColor editColor = colorFromHex(0XFF21B7CA);
  static final MaterialColor phoneColor = colorFromHex(0XFF21B7CA);
  static final MaterialColor mapColor = colorFromHex(0XFF21B7CA);
  static final MaterialColor deleteColor = colorFromHex(0XFFD9534F);
  static final MaterialColor onlineColor = colorFromHex(0XFF5CB85C);
  static final MaterialColor offlineColor = colorFromHex(0XFFD9534F);
}