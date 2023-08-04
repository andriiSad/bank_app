import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../common/values/app_colors.dart';
import '../../../common/values/app_layout.dart';
import '../../../common/values/app_styles.dart';
import '../../../logic/app/bloc/app_bloc.dart';
import '../../../logic/app/bloc/app_events.dart';
import '../../../logic/app/bloc/app_states.dart';
import '../../../models/credit_card.dart';
import '../../../models/user.dart';
import 'widgets/card_view.dart';
import 'widgets/transactions_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AppBloc>().state.user;
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.getWidth(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          BlocBuilder<AppBloc, AppState>(
                            builder: (context, state) {
                              return Text(
                                state.user.username!,
                                style: AppStyles.logoStyle.copyWith(
                                  color: AppColors.black,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<AppBloc>()
                              .add(const AppLogoutRequested());
                        },
                        icon: Icon(
                          Icons.logout,
                          size: AppLayout.getWidth(30),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(AppLayout.getHeight(30)),
                Text(
                  'Total Balance',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
                Gap(AppLayout.getHeight(10)),
                Text(
                  '\$${user.cards.fold(0, (previousValue, card) => previousValue + card.balance)}',
                  style: AppStyles.titleStyle.copyWith(
                    color: AppColors.black,
                  ),
                ),
                Gap(AppLayout.getHeight(30)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocBuilder<AppBloc, AppState>(
                    builder: (context, state) {
                      final List<CreditCard> cards = state.user.cards;
                      return Row(
                        children: cards.map((card) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: AppLayout.getWidth(20),
                            ),
                            child: CardView(card: card),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: AppLayout.getHeight(320),
                child: const TransactionsView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
