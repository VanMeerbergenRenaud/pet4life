import 'package:flutter/material.dart';

import 'package:pet4life/styles/colors.dart';
import 'package:pet4life/styles/spacings.dart';

class SettingsPageScreen extends StatelessWidget {
  const SettingsPageScreen({super.key});

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('Settings Page'),
        backgroundColor: kMainColor,
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
              child : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Settings Page',
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Logout user with Firebase instance

                    },
                    child: const Text('Logout'),
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
