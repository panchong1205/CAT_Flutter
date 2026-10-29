import 'package:flutter/material.dart';
import 'device_class_provider.dart';

class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets? phonePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.phonePadding,
    this.tabletPadding,
    this.desktopPadding,
  });

  @override
  Widget build(BuildContext context) {
    final device = DeviceClassProvider.of(context);
    EdgeInsets padding;

    switch (device.deviceClass) {
      case DeviceClass.phone:
        padding = phonePadding ?? const EdgeInsets.all(12);
      case DeviceClass.tablet:
        padding = tabletPadding ?? const EdgeInsets.all(20);
      case DeviceClass.desktop:
        padding = desktopPadding ?? const EdgeInsets.all(28);
    }

    return Padding(padding: padding, child: child);
  }
}