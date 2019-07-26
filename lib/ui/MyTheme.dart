import 'package:flutter/material.dart';

class MyColors {
  const MyColors();

  static const Color primaryColor = const Color(0xFFdd2c00);
  static const Color primaryLightColor = const Color(0xFFff6434);
  static const Color primaryDarkColor = const Color(0xFFa30000);
  static const Color secondaryColor = const Color(0xFF457b9d);
  static const Color secondaryLightColor = const Color(0xFF76aace);
  static const Color secondaryDarkColor = const Color(0xFF094f6f);
  static const Color primaryTextColor = const Color(0xFFffffff);
  static const Color secondaryTextColor = const Color(0xFFffffff);
  static const Color whitePrimaryColor = const Color(0xFFffffff);
  //static const Color whitePrimaryColor = const Color(0xFFfbe9e7);
  static const Color whiteSecondaryColor = const Color(0xFFeceff1);
}

class TextStyles {
  const TextStyles();

  static const TextStyle headerText = const TextStyle(
      color: MyColors.primaryTextColor,
      fontWeight: FontWeight.normal,
      fontSize: 20.0);

  static const TextStyle categoryHeaderText = const TextStyle(
      color: MyColors.primaryColor,
      fontWeight: FontWeight.normal,
      fontSize: 25.0);

  static const TextStyle categoryText = const TextStyle(
      color: MyColors.primaryLightColor,
      fontWeight: FontWeight.normal,
      fontSize: 15.0);


}
