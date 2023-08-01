import 'package:flutter/material.dart';

import 'common/values/app_colors.dart';
import 'common/values/app_styles.dart';

final theme = ThemeData(
  textTheme: TextTheme(
    titleLarge: AppStyles.titleStyle,
    bodyLarge: AppStyles.textStyle,
  ),
  primaryColorDark: AppColors.darkGrey,
  primaryColorLight: AppColors.grey,
  primaryColor: AppColors.red,
  scaffoldBackgroundColor: AppColors.grey,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
