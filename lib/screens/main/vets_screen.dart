import 'package:flutter/material.dart';

import '../../styles/font.dart';
import 'template_screen.dart';

class VetsPageScreen extends StatelessWidget {
  const VetsPageScreen({super.key});

  static const String routeName = '/vets';

  @override
  Widget build(BuildContext context) {
    return const HomePageTemplate(
        title: Text(
          'Vos vétérinaires',
          textAlign: TextAlign.center,
          style: kTitleStyleWhite,
        ),
        flexibleContent: Text('Vets')
    );
  }
}
