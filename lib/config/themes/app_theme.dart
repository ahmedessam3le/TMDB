import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdb/core/utils/app_colors.dart';
import 'package:tmdb/core/utils/app_responsive.dart';
import 'package:tmdb/core/utils/app_strings.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: AppColors.primarySwatch,
    primaryColor: AppColors.primaryColor,
    hintColor: AppColors.hintColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    fontFamily: AppStrings.fontFamily,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.hintColor,
      ),
      headline5: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.hintColor,
      ),
      subtitle2: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.hintColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.yellow.shade200,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColors.primaryColor,
      titleTextStyle: TextStyle(
        color: AppColors.hintColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.hintColor, size: 30.r),
    ),
  );
}
