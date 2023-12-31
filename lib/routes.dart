import 'package:flutter/cupertino.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'widgets/onboarding.dart';

Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
};
