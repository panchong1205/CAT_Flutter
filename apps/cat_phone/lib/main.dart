import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_core/cat_core.dart';

/// CUSTOM Phone App — 手机端入口
///
/// 锁定竖屏方向，使用 [PhoneShell] 底部导航栏布局。
/// 基于 [StatefulShellRoute.indexedStack] 管理 6 个分支 tab。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await initializeDependencies();

  runApp(const ProviderScope(child: PhoneApp()));
}

/// 手机端 App 根组件
///
/// 配置 Material 3 亮色主题 + GoRouter 路由 + viewInsets clamp 修复。
class PhoneApp extends StatelessWidget {
  const PhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter(AppType.phone);

    return MaterialApp.router(
      title: 'CUSTOM Phone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: const Color(0xFF2E7D32),
        useMaterial3: true,
      ),
      routerConfig: router,
      builder: (context, child) => _clampViewInsets(context, child),
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