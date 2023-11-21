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
    final username = user?.displayName ?? 'invité'; //user?.email works

    return HomePageTemplate(
      title: Text(
        'Bienvenue $username',
        textAlign: TextAlign.left,
        style: kTitleStyleWhite,
      ),
      flexibleContent: const Text('Page d‘accueil'),
    );
  }
}

