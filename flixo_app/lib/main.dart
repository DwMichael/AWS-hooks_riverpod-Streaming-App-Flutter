// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flixo_app/pages/authentication/login_page.dart';
import 'package:flixo_app/pages/home_page.dart';
import 'package:flixo_app/theme/theme.dart';
import 'package:flixo_app/theme/theme_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const LoginPage(),
    );
  }
}
