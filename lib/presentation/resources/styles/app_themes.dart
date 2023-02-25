import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_style.dart';
import '../constants/app_values.dart';

class AppTheme {
  static ThemeData getLight() {
    return ThemeData(
      // main colors
      primaryColor: AppColors.orange,
      primaryColorDark: AppColors.darkOrange,
      primaryColorLight: AppColors.lightOrange,
      disabledColor: AppColors.grey1,
      splashColor: AppColors.lightOrange,

      // CardView theme
      /// what's this theme used for
      cardTheme: const CardTheme(
          color: AppColors.white,
          shadowColor: AppColors.grey,
          elevation: AppSize.s4),

      // AppBar theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: AppColors.orange,
        elevation: AppSize.s4,
        shadowColor: AppColors.lightOrange,
        titleTextStyle: AppStyle.getRegular(
          color: AppColors.white,
          fontSize: AppFontSize.f16,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: AppColors.orange,
        ),
      ),

      // button theme
      buttonTheme: const ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: AppColors.grey1,
        buttonColor: AppColors.orange,
        splashColor: AppColors.lightOrange,
      ),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: AppStyle.getRegular(
            color: AppColors.white,
            fontSize: AppFontSize.f17,
          ),
          backgroundColor: AppColors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
        ),
      ),

      // text theme
      textTheme: TextTheme(
        headlineLarge: AppStyle.getSemiBold(
          color: AppColors.darkGrey,
          fontSize: AppFontSize.f16,
        ),
        headlineMedium: AppStyle.getRegular(
          color: AppColors.darkGrey,
          fontSize: AppFontSize.f14,
        ),
        titleMedium: AppStyle.getMedium(
          color: AppColors.lightGrey,
          fontSize: AppFontSize.f14,
        ),
        titleSmall: AppStyle.getMedium(
          color: AppColors.orange,
          fontSize: AppFontSize.f16,
        ),
        bodyMedium: AppStyle.getRegular(
          color: AppColors.grey1,
        ),
        bodySmall: AppStyle.getRegular(
          color: AppColors.grey,
        ),
      ),

      /// input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppSize.s8),
        hintStyle: AppStyle.getRegular(
            color: AppColors.grey, fontSize: AppFontSize.f14),
        labelStyle: AppStyle.getMedium(
            color: AppColors.orange, fontSize: AppFontSize.f14),

        /// enabled border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide:
              const BorderSide(color: AppColors.grey, width: AppSize.s1),
        ),

        // focused border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide:
              const BorderSide(color: AppColors.orange, width: AppSize.s1),
        ),

        // error border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: const BorderSide(color: AppColors.red, width: AppSize.s1),
        ),

        // focused error border
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          borderSide: const BorderSide(color: AppColors.red, width: AppSize.s1),
        ),
      ),
    );
  }
}
