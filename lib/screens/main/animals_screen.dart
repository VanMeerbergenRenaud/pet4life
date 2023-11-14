import 'package:flutter/material.dart';
import 'package:pet4life/styles/font.dart';
import 'package:pet4life/styles/spacings.dart';

import '../../styles/colors.dart';

class AnimalsPageScreen extends StatelessWidget {
  const AnimalsPageScreen({super.key});

  static const String routeName = '/animals';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(kPadding),
              child: Text(
                'Vos animaux',
                textAlign: TextAlign.center,
                style: kTitleStyleWhite,
              ),
            ),
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24.0),
                    topLeft: Radius.circular(24.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
