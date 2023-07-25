import 'package:bank_app/common/values/app_colors.dart';
import 'package:bank_app/common/values/app_layout.dart';
import 'package:bank_app/common/values/app_styles.dart';
import 'package:bank_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = AppLayout.getSize(context);
    return Scaffold(
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: AppLayout.getHeight(250),
            left: AppLayout.getWidth(30),
            right: AppLayout.getWidth(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/bank_logo.svg',
                        colorFilter: ColorFilter.mode(
                          AppColors.red,
                          BlendMode.srcIn,
                        ),
                        height: AppLayout.getHeight(40),
                        width: AppLayout.getHeight(40),
                      ),
                      Gap(AppLayout.getWidth(5)),
                      Text(
                        'Cosmo Bank',
                        style: AppStyles.logoStyle,
                      ),
                    ],
                  ),
                  Gap(AppLayout.getHeight(15)),
                  RichText(
                    text: TextSpan(
                      style: AppStyles.titleStyle,
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Finances become\n',
                        ),
                        const TextSpan(
                          text: 'cosmically ',
                        ),
                        TextSpan(
                          text: 'simple',
                          style: AppStyles.titleStyle.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        const TextSpan(
                          text: '!',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: AppLayout.getHeight(10)),
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
