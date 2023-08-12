import 'package:flutter/material.dart';

import '../../common/values/app_colors.dart';
import '../../common/values/app_styles.dart';

class SingleTransaction extends StatelessWidget {
  //TODO: check what fields to pass here, we need photoUrl, id, etc..
  const SingleTransaction({
    super.key,
    required this.username,
    required this.amount,
  });

  final String username;
  final int amount;

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
                  'Money Transfer',
                  style: AppStyles.textStyle.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  username,
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
          '\$$amount',
          style: AppStyles.textStyle.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
