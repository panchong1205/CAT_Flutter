import 'package:flutter/material.dart';
import 'fleet_list_page.dart';

/// 车队设备管理页面入口
///
/// 直接委托给 [FleetListPage] 负责车辆列表和数据展示。
/// 注意：该 Widget 仍然接收 [title] 以兼容 GoRouter 路由定义，
/// 但标题文本由 FleetListPage 内部的 Header 区域自行渲染。
class FleetPage extends StatelessWidget {
  final String title;
  const FleetPage({super.key, this.title = '车队设备'});

  @override
  Widget build(BuildContext context) {
    return const FleetListPage();
  }
}