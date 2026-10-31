import 'package:flutter/material.dart';

/// 设备形态枚举
enum DeviceClass { phone, tablet, desktop }

/// 设备形态感知 Provider
///
/// 基于屏幕宽度自动分类当前设备为 phone(&lt;600px)、tablet(600-1024px) 或 desktop(&gt;1024px)。
/// 作为 [InheritedWidget] 注入到 Widget 树，所有子孙节点通过 [of] 或 [maybeOf] 获取。
/// 同时感知屏幕方向（[isLandscape]），用于自适应布局调整。
class DeviceClassProvider extends InheritedWidget {
  final DeviceClass deviceClass;
  final bool isLandscape;

  const DeviceClassProvider({
    super.key,
    required this.deviceClass,
    required this.isLandscape,
    required super.child,
  });

  static DeviceClassProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DeviceClassProvider>();
  }

  static DeviceClassProvider of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No DeviceClassProvider found in context');
    return result!;
  }

  static DeviceClass classify(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return DeviceClass.phone;
    if (width < 1024) return DeviceClass.tablet;
    return DeviceClass.desktop;
  }

  @override
  bool updateShouldNotify(DeviceClassProvider oldWidget) {
    return deviceClass != oldWidget.deviceClass || isLandscape != oldWidget.isLandscape;
  }
}