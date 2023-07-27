import 'package:bank_app/common/values/app_colors.dart';
import 'package:bank_app/common/values/app_layout.dart';
import 'package:bank_app/common/values/app_styles.dart';
import 'package:bank_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:numpad_layout/numpad.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppLayout.getWidth(30),
            vertical: AppLayout.getHeight(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    'Send Money',
                    style: AppStyles.textStyle.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                    width: 24,
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              NumPad(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                onType: (value) {},
                runSpace: 30,
                numberStyle: AppStyles.titleStyle.copyWith(
                  color: AppColors.black,
                  fontSize: 30,
                ),
                rightWidget:
                    const Icon(Icons.arrow_circle_left_outlined, size: 45),
                leftWidget: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const Gap(15),
              AppButton(
                text: 'Send Money',
                callback: () {},
                backGroundColor: AppColors.black,
                textColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
