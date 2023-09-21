import 'package:flutter/material.dart';
import 'package:smart_shop/constant/app_colors.dart';

class Style {
  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          iconTheme:
              IconThemeData(color: isDarkTheme ? Colors.white : Colors.black),
          backgroundColor: isDarkTheme
              ? AppColors.darkScaffoldColor
              : AppColors.lightScaffoldColor,
          titleTextStyle: TextStyle(
            color: isDarkTheme
                ? AppColors.lightScaffoldColor
                : AppColors.darkScaffoldColor,
          ),
          elevation: 0,
          // backgroundColor:
        ),
        scaffoldBackgroundColor: isDarkTheme
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        cardColor: isDarkTheme
            ? const Color.fromARGB(255, 13, 6, 27)
            : AppColors.lightCardColor,
        dialogBackgroundColor: isDarkTheme ? Colors.white : Colors.black,
        navigationBarTheme: NavigationBarThemeData(
            elevation: 0,
            backgroundColor: isDarkTheme
                ? AppColors.darkScaffoldColor
                : AppColors.lightScaffoldColor));
  }
}
