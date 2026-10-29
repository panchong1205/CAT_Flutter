import 'package:flutter/material.dart';
import '../widgets/mine_map_widget.dart';

/// 矿区地图页面
///
/// 集成 flutter_map + OpenStreetMap 瓦片，叠加车辆位置标记、告警气泡、
/// 任务路线和点击交互弹窗。替代 Step 11 之前的占位页面。
class MapPage extends StatelessWidget {
  final String title;
  const MapPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        const MineMapWidget(),

        // 左上角标题浮层
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: colors.surface.withAlpha(230),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(30),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.map, size: 18, color: colors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}