import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class VetsPageScreen extends StatelessWidget {
  const VetsPageScreen({super.key});

  static const String routeName = '/vets';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('Vets Page'),
        backgroundColor: kMainColor,
      ),
      body: const SafeArea(
        child: Text('Vets Page'),
      ),
    );
  }
}
