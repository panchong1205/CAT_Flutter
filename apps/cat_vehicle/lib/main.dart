import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_core/cat_core.dart';

/// CUSTOM Vehicle App — 车载终端入口
///
/// 强制横屏显示，使用车载暗色高对比度主题。
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化 GetIt DI 容器（注册 Mock Repository 实现）
  await initializeDependencies();
  // 锁定横屏方向
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const VehicleApp());
}

class VehicleApp extends StatelessWidget {
  const VehicleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter(AppType.vehicle);
    // ProviderScope 包裹整个 App，使得 Riverpod Provider 可用
    return ProviderScope(
      child: MaterialApp.router(
        title: 'CUSTOM Vehicle',
        debugShowCheckedModeBanner: false,
        theme: CatThemes.vehicleTheme,
        routerConfig: router,
        builder: (context, child) => _clampViewInsets(context, child),
      ),
    );
  }
}

/// 修复 Flutter Web 键盘收起时 viewInsets 为负值的已知 bug
///
/// 将 viewInsets 各分量 clamp 到 [0, ∞)，防止断言失败。
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