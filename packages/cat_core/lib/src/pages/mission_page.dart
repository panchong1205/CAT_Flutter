import 'package:flutter/material.dart';
import 'mission_list_page.dart';

/// 任务管理页面（入口）
///
/// 作为 GoRouter 路由的目标页面，实际内容委托给 [MissionListPage] 渲染。
/// Step 8 已将占位页面升级为完整功能页面。
class MissionPage extends StatelessWidget {
  final String title;
  const MissionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const MissionListPage(title: '任务管理');
  }
}