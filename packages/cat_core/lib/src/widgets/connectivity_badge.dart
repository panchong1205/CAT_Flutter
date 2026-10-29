import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import '../providers/connectivity_provider.dart';

/// 离线模式 Badge 组件
///
/// 网络断开时在页面顶部显示橙色提示条，网络恢复后自动消失并带淡出动画。
class ConnectivityBadge extends ConsumerWidget {
  const ConnectivityBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider).valueOrNull ?? true;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment.topCenter,
      curve: Curves.easeInOut,
      child: isOnline
          ? const SizedBox.shrink()
          : AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isOnline ? 0.0 : 1.0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: CatColors.alertWarning,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.wifi_off, size: 16, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      '离线模式 — 数据来自本地缓存',
                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}