import 'package:flutter/material.dart';

import 'core/auth/session_store.dart';
import 'core/theme/theme.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/home/presentation/home_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final rememberedUser = await SessionStore.instance.currentUser();
  runApp(MyApp(startLoggedIn: rememberedUser != null));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.startLoggedIn = false});

  /// Whether a remembered session was found at startup, so we can skip login.
  final bool startLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Badar Tyres',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: startLoggedIn ? const HomeShell() : const LoginScreen(),
    );
  }
}
