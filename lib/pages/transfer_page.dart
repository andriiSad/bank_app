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
        backgroundColor: AppColors.grey,
        body: Container(
          padding: EdgeInsets.only(
            top: AppLayout.getHeight(15),
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
              Container(
                height: 120,
                width: 120,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/ivan.jpg'),
                  ),
                  border: Border.all(
                    color: Colors.purple,
                    width: 5,
                  ),
                ),
              ),
              Gap(10),
              Text(
                'Ivan Lieskov',
                style: AppStyles.logoStyle.copyWith(color: AppColors.darkGrey),
              ),
              Container(
                height: 40,
                width: 200,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          'VISA',
                          style: AppStyles.titleStyle.copyWith(
                            color: AppColors.red,
                            fontSize: 16,
                          ),
                        ),
                        Gap(15),
                        Text(
                          '**1892',
                          style: AppStyles.titleStyle.copyWith(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppLayout.getWidth(30),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Gap(10),
                    Container(
                      height: 50,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.darkGrey,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          '\$250',
                          style: AppStyles.logoStyle.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                    const Gap(5),
                    Text(
                      '2% commision. Total ammount: \$250',
                      style: AppStyles.textStyle.copyWith(
                        color: AppColors.darkGrey,
                        fontSize: 12,
                      ),
                    ),
                    const Gap(20),
                    NumPad(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      onType: (value) {},
                      runSpace: 30,
                      numberStyle: AppStyles.titleStyle.copyWith(
                        color: AppColors.black,
                        fontSize: 30,
                      ),
                      rightWidget: const Icon(Icons.arrow_circle_left_outlined, size: 45),
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
            ],
          ),
        ),
      ),
    );
  }
}
