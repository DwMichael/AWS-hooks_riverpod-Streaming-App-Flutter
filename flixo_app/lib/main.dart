// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flixo_app/pages/authentication/login_page.dart';
import 'package:flixo_app/pages/authentication/sign_up.dart';
import 'package:flixo_app/pages/main_pages/download_page.dart';
import 'package:flixo_app/pages/main_pages/home_page.dart';
import 'package:flixo_app/pages/main_pages/search_page.dart';

import 'package:flixo_app/theme/theme.dart';
import 'package:flixo_app/theme/theme_manager.dart';
import 'package:flixo_app/widget/main_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'amplifyconfiguration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAmplifySuccessfullyConfigured = false;
  try {
    await _configureAmplify();
    isAmplifySuccessfullyConfigured = true;
  } on AmplifyAlreadyConfiguredException {
    debugPrint('Amplify configuration failed.');
  }

  runApp(
    ProviderScope(
        child: MyApp(
      isAmplifySuccessfullyConfigured: isAmplifySuccessfullyConfigured,
    )),
  );
}

Future<void> _configureAmplify() async {
  await Amplify.addPlugins([
    AmplifyAuthCognito(),
  ]);
  await Amplify.configure(amplifyconfig);
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isAmplifySuccessfullyConfigured});
  final bool isAmplifySuccessfullyConfigured;
  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        title: 'Flixio',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeManager.themeMode,
        initialRoute: '/',
        builder: Authenticator.builder(),
        routes: {
          // '/': (context) => LoginPage(),
          '/': (context) => const MainBottomBar(
                isElevated: true,
                isVisible: true,
              ),
          // SignUpPage.routeName: (context) => const SignUpPage(),
          // HomePage.routName: (context) => HomePage(title: "Home Page"),
          // SearchPage.routName: (context) => SearchPage(title: "Search Page"),
          // DownLoadPage.routName: (context) => DownLoadPage()
        },
      ),
    );
  }
}
