import 'package:flutter/material.dart';

import '../../styles/font.dart';
import 'template_screen.dart';

class RemindersPageScreen extends StatelessWidget {
  const RemindersPageScreen({super.key});

  static const String routeName = '/reminders';

  @override
  Widget build(BuildContext context) {
    return const HomePageTemplate(
      title: Text(
        'Vos rappels',
        textAlign: TextAlign.center,
        style: kTitleStyleWhite,
      ),
      flexibleContent: Center(
        child: Text('Vos rappels'),
      ),
    );
  }
}
