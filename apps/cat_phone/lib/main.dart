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
    );
  }
}