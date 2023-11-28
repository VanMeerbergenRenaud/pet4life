import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/spacings.dart';

class SelectOption extends StatelessWidget {
  final String label;
  final String value;
  final String optionValue;
  final VoidCallback onTap;

  const SelectOption({
    required this.label,
    required this.value,
    required this.optionValue,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: optionValue == value ? kSecondaryColor : kWhite,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPaddingL,
            vertical: kVerticalPadding,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}