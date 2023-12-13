import 'package:flutter/material.dart';
import 'package:pet4life/styles/colors.dart';
import 'package:pet4life/styles/font.dart';

import '../styles/spacings.dart';
import 'login_screen.dart';

class ConfidentialityScreen extends StatelessWidget {
  const ConfidentialityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Page de confidentialité',
          style: kLabelStyle,
        ),
        backgroundColor: kSecondaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingL,
              vertical: kPaddingS,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: kPaddingL),
                  child: Text(
                    'Politique de confidentialité',
                    style: kSectionTitle,
                  ),
                ),
                const Text(
                  'Bienvenue sur notre application pour animaux de compagnie. Nous travaillons avec des vétérinaires professionnels pour assurer le bien-être de vos animaux.',
                  style: kText,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Collecte de données :',
                        style: kConfidentialityTitle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: kVerticalPaddingS, bottom: kVerticalPadding),
                        child: Text(
                          'Nous ne collectons pas vos données pour les vendre à des tiers ni pour les partager avec des tiers. La confidentialité de vos données est une priorité pour nous.',
                          style: kText,
                        ),
                      ),
                      Text(
                        'Utilisation des données collectées :',
                        style: kConfidentialityTitle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: kVerticalPaddingS, bottom: kVerticalPadding),
                        child: Text(
                          'Les données collectées sont uniquement utilisées pour améliorer votre expérience utilisateur et pour fournir des services liés à l’application. Nous ne les utilisons pas à d’autres fins.',
                          style: kText,
                        ),
                      ),
                      Text(
                        'Partage de données :',
                        style: kConfidentialityTitle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: kVerticalPaddingS, bottom: kVerticalPadding),
                        child: Text(
                          'Nous ne partageons en aucun cas vos données personnelles avec des tiers sans votre consentement explicite. Votre confidentialité est primordiale pour nous.',
                          style: kText,
                        ),
                      ),
                      Text(
                        'Cookies :',
                        style: kConfidentialityTitle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: kVerticalPaddingS, bottom: kVerticalPadding),
                        child: Text(
                          'Nous utilisons des cookies pour améliorer votre expérience sur notre application, mais nous ne les utilisons pas à des fins de suivi ou de collecte de données personnelles.',
                          style: kText,
                        ),
                      ),
                      Text(
                        'Sécurité des données :',
                        style: kConfidentialityTitle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: kVerticalPaddingS, bottom: kVerticalPadding),
                        child: Text(
                          'Nous prenons des mesures de sécurité strictes pour protéger vos données contre tout accès non autorisé ou toute divulgation non autorisée.',
                          style: kText,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kPaddingS),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Accepter et continuer',
                      style: kTextButtonOrange,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
