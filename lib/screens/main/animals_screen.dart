import 'package:flutter/material.dart';

import '../../styles/font.dart';
import '../../styles/spacings.dart';
import '../../widgets/card.dart' as my_card;
import 'template_screen.dart';

class AnimalsPageScreen extends StatelessWidget {
  const AnimalsPageScreen({super.key});

  static const String routeName = '/animals';

  @override
  Widget build(BuildContext context) {
    return HomePageTemplate(
      title: const Text(
        'Vos animaux',
        textAlign: TextAlign.center,
        style: kTitleStyleWhite,
      ),
      flexibleContent: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: kHorizontalPadding,
          mainAxisSpacing: kHorizontalPadding,
          children: List.generate(
            10,
            (index) {
              return const my_card.Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(kPaddingS),
                      child: Text(
                        'Dog',
                        style: kTitleStyle,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
