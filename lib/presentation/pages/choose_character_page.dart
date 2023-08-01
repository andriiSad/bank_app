import 'package:flutter/material.dart';

class ChooseCharacterPage extends StatelessWidget {
  const ChooseCharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/light_background.jpg'))),
      ),
    );
  }
}
