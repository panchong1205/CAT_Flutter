import 'package:flutter/material.dart';
import 'device_class_provider.dart';

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