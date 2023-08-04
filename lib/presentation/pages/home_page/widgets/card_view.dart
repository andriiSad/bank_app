import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../common/values/app_colors.dart';
import '../../../../common/values/app_layout.dart';
import '../../../../common/values/app_styles.dart';
import '../../../../models/credit_card.dart';

class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.card,
  });

  final CreditCard card;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getHeight(250),
      width: AppLayout.getWidth(200),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.getWidth(20),
                    vertical: AppLayout.getHeight(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/images/bank_logo.svg',
                          colorFilter: ColorFilter.mode(
                            AppColors.red,
                            BlendMode.srcIn,
                          ),
                          height: AppLayout.getHeight(30),
                          width: AppLayout.getHeight(30),
                        ),
                        Text(
                          '**${card.cardId}',
                          style: AppStyles.textStyle.copyWith(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Gap(
                      AppLayout.getHeight(15),
                    ),
                    Text(
                      '\$${card.balance}',
                      style: AppStyles.titleStyle.copyWith(
                        color: AppColors.black,
                        fontSize: 26,
                      ),
                    ),
                    Gap(
                      AppLayout.getHeight(15),
                    ),
                    Text(
                      card.type.toStringValue(),
                      style: AppStyles.textStyle.copyWith(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: AppColors.red,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  left: AppLayout.getWidth(20),
                  top: AppLayout.getHeight(20),
                ),
                height: double.maxFinite,
                width: double.maxFinite,
                child: Text(
                  'VISA',
                  style: AppStyles.textStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
