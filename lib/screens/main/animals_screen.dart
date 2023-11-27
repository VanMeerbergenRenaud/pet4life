import 'package:flutter/material.dart';

import '../../styles/font.dart';
import '../../styles/spacings.dart';
import 'template_screen.dart';

class AnimalsPageScreen extends StatefulWidget {
  const AnimalsPageScreen({super.key});

  static const String routeName = '/animals';

  @override
  State<AnimalsPageScreen> createState() => _AnimalsPageScreenState();
}

class _AnimalsPageScreenState extends State<AnimalsPageScreen> {
  // open a modal to create a new animal
  void openAnimalModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Image',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const HomePageTemplate(
      title: Text(
        'Vos animaux',
        textAlign: TextAlign.center,
        style: kTitleStyleWhite,
      ),
      flexibleContent: Padding(
          padding: EdgeInsets.all(kPadding),
          child: Column(
            children: [
              Text('Hello'),
            ],
          )
      ),
    );
  }
}