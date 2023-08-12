import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../common/values/app_colors.dart';
import '../../../../common/values/app_layout.dart';
import '../../../../common/values/app_styles.dart';
import '../../../../logic/bottom_navigation/bottom_navigation_cubit.dart';
import '../../../../logic/bottom_navigation/constants/bottom_nav_bar_items.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
          const Gap(20),
          // Center(
          //   child: Container(
          //     height: 5,
          //     width: 50,
          //     decoration: BoxDecoration(
          //       color: AppColors.darkGrey,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          // ),
          // const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions',
                style: AppStyles.logoStyle.copyWith(color: AppColors.black),
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<BottomNavigationCubit>(context).getNavBarItem(BottomNavbarItem.transactions);
                },
                child: Text(
                  'See all',
                  style: AppStyles.textStyle.copyWith(color: AppColors.darkGrey),
                ),
              ),
            ],
          ),
          const Gap(20),
          SizedBox(
            height: 240,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  15,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      top: AppLayout.getHeight(15),
                    ),
                    //TODO:
                    // child: const SingleTransaction(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
