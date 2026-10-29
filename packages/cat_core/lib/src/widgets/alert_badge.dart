import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import '../providers/alert_provider.dart';

/// 告警计数徽章组件（可复用）
///
/// 在顶部导航栏或侧边栏中显示未确认告警的数量徽章。
/// 当未确认告警数为 0 时不显示徽章，有告警时以红底白字显示计数。
class AlertBadge extends ConsumerWidget {
  /// 需要包裹徽章的图标
  final Widget icon;
  /// 图标的大小
  final double? iconSize;
  /// 徽章的水平偏移
  final double offset;

  const AlertBadge({
    super.key,
    required this.icon,
    this.iconSize,
    this.offset = 6,
  });

  /// 绑定告警徽章的图标组件
  ///
  /// 便捷构造方法，使用默认的告警图标。
  static Widget withIcon({
    required BuildContext context,
    required WidgetRef ref,
    double? iconSize,
  }) {
    return AlertBadge(
      icon: Icon(Icons.warning_amber, size: iconSize),
      iconSize: iconSize,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countAsync = ref.watch(unacknowledgedAlertCountProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        countAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (count) {
            if (count <= 0) return const SizedBox.shrink();

            return Positioned(
              right: -offset,
              top: -offset - 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: CatColors.alertCritical,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: CatColors.alertCritical.withAlpha(80),
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 16),
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}