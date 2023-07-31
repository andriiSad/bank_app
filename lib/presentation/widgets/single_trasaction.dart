import 'package:bank_app/common/values/app_colors.dart';
import 'package:bank_app/common/values/app_styles.dart';
import 'package:flutter/material.dart';

class SingleTransaction extends StatelessWidget {
  const SingleTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.person,
              size: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Figma',
                  style: AppStyles.textStyle.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Software',
                  style: AppStyles.textStyle.copyWith(
                    color: AppColors.darkGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
        Text(
          '- \$11.99',
          style: AppStyles.textStyle.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
