import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cat_core/cat_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await initializeDependencies();

  runApp(const ProviderScope(child: PhoneApp()));
}

class PhoneApp extends StatelessWidget {
  const PhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter(AppType.phone);

    return MaterialApp.router(
      title: 'CAT Phone',
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