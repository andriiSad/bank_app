import 'package:bank_app/common/values/colors.dart';
import 'package:bank_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profile_photos/welcome_background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 250,
            left: 30,
            right: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cosmo_Bank',
                    style: TextStyle(
                      fontSize: 26,
                      color: AppColors.white,
                    ),
                  ),
                  const Gap(15),
                  Text(
                    'Finances become\ncosmically simple!',
                    style: TextStyle(
                      fontSize: 40,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SafeArea(
                  child: AppButton(
                    text: 'Get Started',
                    callback: () {},
                    backGroundColor: AppColors.white,
                    textColor: AppColors.black,
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
