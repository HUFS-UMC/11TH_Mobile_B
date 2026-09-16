import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  // 공통 TextStyle: 화면마다 같은 스타일을 다시 쓰지 않는다.
  static const pageTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.violet,
  );

  static const titleLarge = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static const bodyMedium = TextStyle(
    fontSize: 18,
    color: AppColors.black,
    height: 1.55,
  );

  static const bodySmall = TextStyle(
    fontSize: 14,
    color: AppColors.gray,
    height: 1.4,
  );
}
