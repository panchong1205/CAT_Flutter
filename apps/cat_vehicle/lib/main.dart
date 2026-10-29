import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_design_system/cat_design_system.dart';
import 'package:cat_core/cat_core.dart';

/// CAT Vehicle App — 车载终端入口
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
        title: 'CAT Vehicle',
        debugShowCheckedModeBanner: false,
        theme: CatThemes.vehicleTheme,
        routerConfig: router,
      ),
    );
  }
}