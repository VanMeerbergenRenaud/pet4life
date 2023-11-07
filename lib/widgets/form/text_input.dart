import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/font.dart';
import '../../styles/spacings.dart';

@immutable
class TextInput extends StatelessWidget {
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? tooltipMessage;
  final FormFieldValidator<String> validator;

  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const TextInput({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    required this.labelText,
    required this.validator,

    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.tooltipMessage,

    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 10.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: kHorizontalPadding, bottom: 10),
            child: tooltipMessage != null ? Tooltip (
              height: 32,
              message: tooltipMessage,
              child: Row(
                children: [
                  Text(
                    labelText,
                    style: kLabelStyle,
                  ),
                  const Icon(
                    Icons.info_outline,
                    color: kMainColor,
                    size: kInfoIconSize,
                  )
                ],
              ),
            ) : Text(
              labelText,
              style: kLabelStyle,
            )),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: kVerticalPadding),
            prefixIcon: Icon(prefixIcon),
            suffixIcon: suffixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            filled: true,
            fillColor: kBackgroundColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
            errorStyle: kErrorStyle,
            hintStyle: kHintStyle,
          ),
        ),
      ],
    );
  }
}