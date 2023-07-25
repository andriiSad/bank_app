import 'package:bank_app/common/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../common/values/app_colors.dart';
import '../../../common/values/app_layout.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 400,
      width: AppLayout.getScreenWidth(),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(15),
          Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions',
                style: AppStyles.logoStyle.copyWith(color: AppColors.black),
              ),
              Text(
                'See all',
                style: AppStyles.textStyle.copyWith(color: AppColors.darkGrey),
              ),
            ],
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
