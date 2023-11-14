import 'package:flutter/material.dart';

class BuildBox extends StatelessWidget {

  final String image;
  final String genre;

  const BuildBox(this.image, this.genre, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              genre,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 8),
            Text(
              image,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

