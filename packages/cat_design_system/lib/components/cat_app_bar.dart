import 'package:flutter/material.dart';

/// 设计系统通用 AppBar 组件
///
/// 封装 Material 3 [AppBar]，统一三端顶部导航栏样式。
/// 支持自定义 actions、leading 和标题居中配置。
class CatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final double elevation;

  const CatAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      elevation: elevation,
      scrolledUnderElevation: 1,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}