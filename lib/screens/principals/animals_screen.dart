import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class AnimalsPageScreen extends StatelessWidget {
  const AnimalsPageScreen({super.key});

  static const String routeName = '/animals';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('Animals Page'),
        backgroundColor: kSecondaryColor,
      ),
      body: const SafeArea(
        child: Text('Animals Page'),
      ),
    );
  }
}
