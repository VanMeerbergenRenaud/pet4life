import 'package:flutter/material.dart';

class VetsPageScreen extends StatelessWidget {
  const VetsPageScreen({super.key});

  static const String routeName = '/vets';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('Vets Page'),
    );
  }
}
