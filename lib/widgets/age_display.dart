import 'package:flutter/material.dart';
import '../styles/font.dart';

class AgeDisplay extends StatelessWidget {
  final DateTime dob;

  const AgeDisplay({super.key, required this.dob});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    int totalDays = now.difference(dob).inDays;
    int totalMonths = totalDays ~/ 30;

    String age;

    if (totalDays < 31) {
      age = '$totalDays jours';
    } else if (totalDays == 31) {
      age = '1 mois';
    } else if (totalMonths < 12) {
      age = '$totalMonths mois';
    } else if (totalMonths == 12) {
      age = '1 an';
    } else {
      age = '${totalMonths ~/ 12} ans';
    }

    return Text(
      age,
      style: kSmallTitle,
    );
  }
}
