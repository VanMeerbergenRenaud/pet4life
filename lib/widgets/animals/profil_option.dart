import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/others.dart';
import '../../styles/spacings.dart';
import '../../styles/font.dart';

class ProfilOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const ProfilOption({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
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
              color: kWhite,
              borderRadius: BorderRadius.circular(kBorderRadius / 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPaddingL * 2 / 3,
                vertical: kVerticalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon, color: color, size: 28),
                  const SizedBox(width: 20),
                  Text(
                    text,
                    style: kSmallTitle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kBlack,
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
