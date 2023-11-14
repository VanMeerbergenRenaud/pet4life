import 'package:flutter/material.dart';

class RemindersPageScreen extends StatelessWidget {
  const RemindersPageScreen({super.key});

  static const String routeName = '/reminders';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text('Reminders Page'),
    );
  }
}
