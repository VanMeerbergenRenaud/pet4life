/* HomePageTemplate */
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/spacings.dart';

class HomePageTemplate extends StatelessWidget {
  final Widget title;
  final Widget flexibleContent;

  const HomePageTemplate({
    super.key,
    required this.title,
    required this.flexibleContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSecondaryColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: title,
            ),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24.0),
                    topLeft: Radius.circular(24.0),
                  ),
                ),
                child: flexibleContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
