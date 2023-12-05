import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/font.dart';
import 'template_screen.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? '';

    return HomePageTemplate(
      title: Text(
        'Bienvenue $userName !',
        textAlign: TextAlign.left,
        style: kTitleStyleWhite,
      ),
      flexibleContent: const Text('Page d‘accueil'),
    );
  }
}

