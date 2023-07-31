import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/app_colors.dart';
import '../../common/values/app_layout.dart';
import '../../common/values/app_styles.dart';
import '../../logic/bottom_navigation/bottom_navigation_cubit.dart';
import '../../logic/bottom_navigation/constants/bottom_nav_bar_items.dart';
import '../widgets/single_trasaction.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<BottomNavigationCubit>(context).getNavBarItem(BottomNavbarItem.home);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  'Transactions',
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
            Expanded(
              // Wrap the SingleChildScrollView with Expanded
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    15,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        top: AppLayout.getHeight(15),
                        left: AppLayout.getWidth(15),
                        right: AppLayout.getWidth(15),
                      ),
                      child: const SingleTransaction(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
