import 'package:flutter/material.dart';
import 'package:pet4life/styles/colors.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: kMainColor,
      ),
      body: const SafeArea(
        child: Text('Home Page'),
      ),
    );
  }
}
