import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/others.dart';
import '../../styles/spacings.dart';

class SettingsProfil extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  SettingsProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: 12,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: kGreyLight, width: 1),
              borderRadius: BorderRadius.circular(kBorderRadius / 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/img/avatar.png'),
                  ),
                  const SizedBox(width: kPadding),
                  // Box with username and his email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.displayName ?? 'Bienvenue invité'),
                      Text(user?.email ?? 'Adresse mail non renseignée'),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kGrey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
