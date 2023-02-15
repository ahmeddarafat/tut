import 'package:flutter/material.dart';
import 'app_fonts.dart';

class AppStyle {
  static TextStyle _getTextStyle(
      Color color, double fontSize, FontWeight fontWeight) {
    return  TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: AppFontFamily.montserrat,
      fontWeight: fontWeight,
    );
  }

  // light
  static TextStyle getLight({
    required Color color,
    double fontSize = AppFontSize.f12,
  }) {
    return _getTextStyle(color, fontSize, AppFontWeight.light);
  }

  // Regular
  static TextStyle getRegular({
    required Color color,
    double fontSize = AppFontSize.f12,
  }) {
    return _getTextStyle(color, fontSize, AppFontWeight.regular);
  }

  // Medium
  static TextStyle getMedium({
    required Color color,
    double fontSize = AppFontSize.f12,
  }) {
    return _getTextStyle(color, fontSize, AppFontWeight.medium);
  }

  // SemiBold
  static TextStyle getSemiBold({
    required Color color,
    double fontSize = AppFontSize.f12,
  }) {
    return _getTextStyle(color, fontSize, AppFontWeight.semiBold);
  }

  // Bold
  static TextStyle getBold({
    required Color color,
    double fontSize = AppFontSize.f12,
  }) {
    return _getTextStyle(color, fontSize, AppFontWeight.bold);
  }
}
