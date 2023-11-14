import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/font.dart';
import '../../styles/spacings.dart';

@immutable
class TextInput extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String> validator;
  final ValueChanged<String>? onChanged;

  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  final String? initialValue;

  final TextEditingController? controller;

  final FormFieldSetter<String>? onSaved;

  const TextInput({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    required this.labelText,
    required this.validator,

    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,

    this.onChanged,
    this.initialValue,
    this.controller,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 10.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: kHorizontalPadding),
            child: Text(
              labelText,
              style: kLabelStyle,
            )),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          initialValue: initialValue,
          controller: controller,
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
          onSaved: onSaved,
        ),
      ],
    );
  }
}