import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'styles/colors.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kMainColor,
          secondary: kSecondaryColor,
          tertiary: kTertiaryColor,
          background: kBackgroundColor,
        ),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
