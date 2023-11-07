import 'package:flutter/cupertino.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
};