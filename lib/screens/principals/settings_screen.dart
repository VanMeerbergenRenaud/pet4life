import 'package:flutter/material.dart';

import 'package:pet4life/styles/colors.dart';
import 'package:pet4life/styles/others.dart';

import '../../styles/spacings.dart';
import '../../widgets/buttons/settings_option.dart';
import '../../widgets/buttons/settings_profil.dart';

class SettingsPageScreen extends StatelessWidget {
  const SettingsPageScreen({super.key});

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('Settings Page'),
        backgroundColor: kSecondaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Logout user with Firebase instance
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(kPadding),
                child: Column(
                  children: [
                    SettingsProfil(),
                    const SettingsOption(icon: Icons.settings, text: 'Settings'),
                    const SettingsOption(icon: Icons.account_circle, text: 'Account'),
                    const SettingsOption(icon: Icons.notifications, text: 'Notifications'),
                    const SettingsOption(icon: Icons.logout, text: 'Log Out'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
