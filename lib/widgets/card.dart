import 'package:flutter/material.dart';
import 'package:pet4life/styles/colors.dart';

class Card extends StatelessWidget {
  const Card({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: child,
    );
  }
}
