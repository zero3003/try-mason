import 'package:flutter/material.dart';

import '../common/color.dart';
import '../common/const.dart';
import '../helper/color_helper.dart';

class CustomTheme {
  static ThemeData myTheme(BuildContext context) {
    return ThemeData(
      fontFamily: 'Quicksand',
      scaffoldBackgroundColor: colorBackground,
      appBarTheme: const AppBarTheme(
        color: colorBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: colorBlack,
        ),
      ),
      primarySwatch: materialColor(colorPrimary),
      primaryColor: colorPrimary,
      iconTheme: const IconThemeData(
        color: colorPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: Const.borderRadiusCircular,
            ),
          ),
        ),
      ),
      textTheme: myTextTheme.apply(
        bodyColor: colorBlack,
        displayColor: colorBlack,
      ),
      cardTheme: CardTheme(
        shape: Const.roundedShape,
      ),
    );
  }
}

const TextTheme myTextTheme = TextTheme(
  headline1: TextStyle(fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: TextStyle(fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: TextStyle(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: TextStyle(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
  bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.25),
  button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.4),
  overline: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
