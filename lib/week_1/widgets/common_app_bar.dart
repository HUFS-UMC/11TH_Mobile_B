import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/app_text_styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
    this.centerTitle = false,
    this.titleStyle,
  });

  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool centerTitle;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    // 공통 구조는 유지하고 제목·버튼만 매개변수로 받는다.
    return AppBar(
      title: Text(title, style: titleStyle ?? AppTextStyles.pageTitle),
      centerTitle: centerTitle,
      leading: onBack == null
          ? null
          : IconButton(
              tooltip: '뒤로가기',
              icon: SvgPicture.asset(
                'assets/icons/arrow_back.svg',
                width: 24,
                height: 24,
              ),
              onPressed: onBack,
            ),
      actions: actions,
    );
  }

  @override
  // Scaffold가 AppBar 높이를 알 수 있도록 크기를 제공한다.
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
