import 'package:flutter/material.dart';
import 'alert_list_page.dart';

/// 告警中心页面（入口）
///
/// 作为 GoRouter 路由的目标页面，实际内容委托给 [AlertListPage] 渲染。
/// Step 9 已将占位页面升级为完整功能页面。
class AlertPage extends StatelessWidget {
  final String title;
  const AlertPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const AlertListPage(title: '告警中心');
  }
}