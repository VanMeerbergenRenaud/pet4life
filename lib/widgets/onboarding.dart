import 'package:flutter/material.dart';
import 'package:pet4life/screens/login_screen.dart';
import 'package:pet4life/styles/colors.dart';
import 'package:pet4life/styles/font.dart';
import 'package:pet4life/widgets/buttons/main_button.dart';

import '../screens/confidentiality.dart';
import '../styles/spacings.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const String routeName = '/onboarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kVerticalPaddingL),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardData.length,
                  itemBuilder: (context, index) => OnBoardingContent(
                    image: onboardData[index].image,
                    title: onboardData[index].title,
                    description: onboardData[index].description,
                    currentIndex: index,
                    mainButtonLabel: index == onboardData.length - 1
                        ? "C’est parti !"
                        : "Suivant",
                    mainButtonOnTap: () {
                      if (index == onboardData.length - 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 10),
                          curve: Curves.ease,
                        );
                      }
                    },
                    textButtonLabel: index == onboardData.length - 1
                        ? "Politique de confidentialité"
                        : "Passer",
                    textButtonOnTap: () {
                      if (index == onboardData.length - 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConfidentialityScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;

  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> onboardData = [
  Onboard(
    image: "assets/icons/logo_app.png",
    title: "Bienvenue sur Pet4Life",
    description:
        "Garder toutes les informations importantes sur votre animal de compagnie et sa santé en un endroit ",
  ),
  Onboard(
    image: "assets/img/onboarding_1.png",
    title: "Consultation vétérinaire",
    description:
        "Garder toutes les informations importantes sur votre animal de compagnie et sa santé en un seul et unique endroit.",
  ),
  Onboard(
    image: "assets/img/onboarding_2.png",
    title: "Rappels importants",
    description:
        "Garder toutes les informations importantes sur votre animal de compagnie et sa santé en un seul et unique endroit.",
  ),
  Onboard(
    image: "assets/img/onboarding_3.png",
    title: "Participer à des activités",
    description:
        "Garder toutes les informations importantes sur votre animal de compagnie et sa santé en un seul et unique endroit.",
  ),
];

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.mainButtonLabel,
    required this.mainButtonOnTap,
    required this.textButtonLabel,
    required this.textButtonOnTap,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: kVerticalPaddingL, bottom: kVerticalPadding),
          child: Image.asset(
            image,
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        // Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < onboardData.length; i++)
              if (i == currentIndex)
                const Padding(
                  padding: EdgeInsets.all(kPaddingS),
                  child: DotIndicator(isActive: true),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(kPaddingS),
                  child: DotIndicator(isActive: false),
                ),
          ],
        ),

        Text(
          title,
          style: kTitleStyle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: kText,
          ),
        ),
        const SizedBox(height: kPadding),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
          child: Row(
            children: [
              Expanded(
                child: MainButton(
                  label: mainButtonLabel,
                  onTap: mainButtonOnTap,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: textButtonOnTap,
          child: Text(
            textButtonLabel,
            style: kText,
          ),
        ),
      ],
    );
  }

  final String image, title, description, mainButtonLabel, textButtonLabel;

  final VoidCallback mainButtonOnTap, textButtonOnTap;
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive ? 10 : 8,
      width: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? kSecondaryColor : kGrey,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
