import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/others.dart';
import '../../styles/spacings.dart';

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String text;

  const SettingsOption({
    super.key,
    required this.icon,
    required this.text,
  });

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
                  Icon(icon, color: kGrey),
                  const SizedBox(width: 20),
                  Text(text),
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
