import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_core/cat_core.dart';

/// CUSTOM Tablet App — 平板调度终端入口
///
/// 自适应窗口大小：宽屏 NavigationRail 双栏 / 窄屏 BottomNav 单栏。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化 GetIt DI 容器（注册 Mock Repository 实现）
  await initializeDependencies();
  runApp(const TabletApp());
}

class TabletApp extends StatelessWidget {
  const TabletApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter(AppType.tablet);
    // ProviderScope 包裹整个 App，使得 Riverpod Provider 可用
    return ProviderScope(
      child: MaterialApp.router(
        title: 'CUSTOM Tablet',
        debugShowCheckedModeBanner: false,
        theme: CatThemes.tabletTheme,
        routerConfig: router,
        builder: (context, child) => _clampViewInsets(context, child),
      ),
    );
  }
}

/// 修复 Flutter Web 键盘收起时 viewInsets 为负值的已知 bug
Widget _clampViewInsets(BuildContext context, Widget? child) {
  final data = MediaQuery.of(context);
  final insets = data.viewInsets;
  return MediaQuery(
    data: data.copyWith(
      viewInsets: EdgeInsets.fromLTRB(
        insets.left.clamp(0.0, double.infinity),
        insets.top.clamp(0.0, double.infinity),
        insets.right.clamp(0.0, double.infinity),
        insets.bottom.clamp(0.0, double.infinity),
      ),
    ),
    child: child!,
  );
}