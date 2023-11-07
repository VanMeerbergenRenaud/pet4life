import 'package:flutter/material.dart';

import '../../../styles/colors.dart';
import '../../../styles/font.dart';
import '../../../styles/others.dart';
import '../../../styles/spacings.dart';

class MainButton extends StatelessWidget {
  final String label;
  final GestureTapCallback? onTap;

  final bool mainColor; // Optionnel

  const MainButton({
    super.key,
    required this.label,
    required this.onTap,
    this.mainColor = true,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = mainColor ? kMainColor : kSecondaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: buttonColor, // Opérateur ternaire ? avec mainColor
          borderRadius: BorderRadius.circular(kBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 6),
              blurRadius: 6,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 12),
              blurRadius: 12,
            ),
          ],
        ),
        child: Text(
          label,
          style: kButtonStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}