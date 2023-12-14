import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'styles/colors.dart';
import 'widgets/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet4Life App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: kMainColor,
          secondary: kSecondaryColor,
          tertiary: kTertiaryColor,
          background: kBackgroundColor,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen(),
      // home: LoginScreen()
    );
  }
}

// delete db if needed (from terminal) :
// $ firebase firestore:delete --all-collections --project pet4life-2023-2024
