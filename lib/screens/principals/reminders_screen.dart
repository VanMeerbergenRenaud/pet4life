import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class RemindersPageScreen extends StatelessWidget {
  const RemindersPageScreen({super.key});

  static const String routeName = '/reminders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('Reminders Page'),
        backgroundColor: kSecondaryColor,
      ),
      body: const SafeArea(
        child: Text('Reminders Page'),
      ),
    );
  }
}
