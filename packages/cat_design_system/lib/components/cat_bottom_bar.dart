import 'package:flutter/material.dart';

class CatBottomBarItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;

  const CatBottomBarItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}

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