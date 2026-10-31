import 'package:flutter/material.dart';

/// 底部导航栏项目数据模型
class CatBottomBarItem {
  /// 未选中状态下显示的图标
  final IconData icon;
  /// 选中状态下显示的图标（可选，默认使用 [icon]）
  final IconData? selectedIcon;
  /// 导航项标签文本
  final String label;

  const CatBottomBarItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}

/// 设计系统底部导航栏组件
///
/// 封装 Material 3 [NavigationBar]，统一三端底部导航的外观和行为。
/// 通过 [CatBottomBarItem] 配置各导航项。
class CatBottomBar extends StatelessWidget {
  final int selectedIndex;
  final List<CatBottomBarItem> items;
  final ValueChanged<int> onItemSelected;

  const CatBottomBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemSelected,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: items.map((item) {
        return NavigationDestination(
          icon: Icon(item.icon),
          selectedIcon: item.selectedIcon != null ? Icon(item.selectedIcon) : null,
          label: item.label,
        );
      }).toList(),
    );
  }
}