import 'package:flutter/material.dart';
import 'device_class_provider.dart';

/// 自适应布局容器
///
/// 提供两种使用模式：
/// 1. 直接包裹 [child]，按默认设备感知方式布局子组件
/// 2. 通过 [builder] 回调按 [DeviceClass] 返回不同布局
///
/// 模式 2 常用于跨端差异化显著的场景（如车载端横屏侧边栏 vs 手机端底部导航）。
class AdaptiveLayout extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, DeviceClass deviceClass)? builder;

  const AdaptiveLayout({
    super.key,
    required this.child,
    this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      final device = DeviceClassProvider.of(context);
      return builder!(context, device.deviceClass);
    }
    return child;
  }
}