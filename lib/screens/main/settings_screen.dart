import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet4life/screens/login_screen.dart';

import '../../styles/font.dart';
import '../../styles/spacings.dart';
import '../../widgets/buttons/settings_option.dart';
import '../../widgets/buttons/settings_profil.dart';

import '../settings/profil_screen.dart';
import 'template_screen.dart';

class SettingsPageScreen extends StatelessWidget {
  const SettingsPageScreen({super.key});

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return HomePageTemplate(
      title: const Text(
        'Paramètres',
        textAlign: TextAlign.center,
        style: kTitleStyleWhite,
      ),
      flexibleContent: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfilScreen(),
                        ),
                      );
                    },
                    child: SettingsProfil(),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Direction la page d'abonnement
                    },
                    child: const SettingsOption(
                      icon: Icons.settings,
                      text: 'Abonnement',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Direction la page des notifications
                    },
                    child: const SettingsOption(
                      icon: Icons.notifications,
                      text: 'Notifications',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Direction la page de confidentialité
                    },
                    child: const SettingsOption(
                      icon: Icons.account_circle,
                      text: 'Confidentialité',
                    ),
                  ),
                  GestureDetector(
                    child: const SettingsOption(
                      icon: Icons.logout,
                      text: 'Log Out',
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
