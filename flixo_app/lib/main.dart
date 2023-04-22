// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flixo_app/pages/authentication/login_page.dart';
import 'package:flixo_app/pages/authentication/sign_up.dart';
import 'package:flixo_app/pages/main_pages/home_page.dart';

import 'package:flixo_app/theme/theme.dart';
import 'package:flixo_app/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flixio',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      initialRoute: '/',
      routes: {
        // '/': (context) => LoginPage(),
        '/': (context) => HomePage(title: "Home Page"),
        SignUpPage.routeName: (context) => const SignUpPage(),
        HomePage.routName: (context) => HomePage(title: "Home Page"),
      },
    );
  }
}
