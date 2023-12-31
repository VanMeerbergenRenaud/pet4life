import 'package:flutter/material.dart';

import 'text_input.dart';

class PasswordInput extends StatefulWidget {
  final IconData prefixIcon;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String> validator;
  final ValueChanged<String>? onChanged;

  final TextEditingController? controller;

  final FormFieldSetter<String>? onSaved;

  final String? initialValue;

  const PasswordInput({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    required this.labelText,
    required this.validator,
    this.onChanged,
    this.controller,
    this.onSaved,
    this.initialValue,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInput(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          validator: widget.validator,
          onChanged: widget.onChanged,
          controller: widget.controller,
          obscureText: _obscureText,
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          onSaved: widget.onSaved,
          initialValue: widget.initialValue,
        ),
      ],
    );
  }
}
