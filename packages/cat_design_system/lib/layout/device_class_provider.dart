import 'package:flutter/material.dart';

enum DeviceClass { phone, tablet, desktop }

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