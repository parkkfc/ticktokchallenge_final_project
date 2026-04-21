import 'package:challenge_final_project/firebase_options.dart';
import 'package:challenge_final_project/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    // 1. 전체 앱을 ProviderScope로 감싸서 Riverpod 상태를 사용할 수 있게 합니다.
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,

      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFECE6C2),
        appBarTheme: AppBarThemeData(backgroundColor: Color(0xFFECE6C2)),
        bottomAppBarTheme: BottomAppBarThemeData(color: Color(0xFFECE6C2)),
      ),
    );
  }
}
