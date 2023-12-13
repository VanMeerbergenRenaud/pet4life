import 'package:flutter/material.dart';
import 'package:pet4life/styles/colors.dart';
import 'package:pet4life/styles/font.dart';

import 'login_screen.dart';

class ConfidentialityScreen extends StatelessWidget {
  const ConfidentialityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confidentialité',
          style: kLabelStyle,
        ),
        backgroundColor: kSecondaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Contenu de confidentialité',
              style: kSectionTitle,
            ),
            const Text(
              'Bienvenue sur notre application pour animaux de compagnie. Nous travaillons avec des vétérinaires professionnels pour assurer le bien-être de vos animaux.',
              style: kText,
            ),
            const Text(
              'Nous ne collectons pas vos données pour les vendre à des tiers. Nous ne collectons pas vos données pour les partager avec des tiers. Nous ne collectons pas vos données pour les vendre à des tiers. Nous ne collectons pas vos données pour les partager avec des tiers.',
              style: kText,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: const Text('Accepter et continuer'),
            )
          ],
        ),
      ),
    );
  }
}
