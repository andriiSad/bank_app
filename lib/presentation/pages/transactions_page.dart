import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/app_colors.dart';
import '../../common/values/app_layout.dart';
import '../../common/values/app_styles.dart';
import '../../logic/app/bloc/app_bloc.dart';
import '../../logic/bottom_navigation/bottom_navigation_cubit.dart';
import '../../logic/bottom_navigation/constants/bottom_nav_bar_items.dart';
import '../../logic/transactions/transactions_cubit.dart';
import '../../logic/transactions/transactions_states.dart';
import '../widgets/single_trasaction.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _TransactionsAppBar(),
            _TransactionsFilters(),
            _TransactionListContent(),
          ],
        ),
      ),
    );
  }
}

class _TransactionsAppBar extends StatelessWidget {
  const _TransactionsAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            BlocProvider.of<BottomNavigationCubit>(context)
                .getNavBarItem(BottomNavbarItem.home);
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
    );
  }
}

class _TransactionsFilters extends StatelessWidget {
  const _TransactionsFilters();

  @override
  Widget build(BuildContext context) {
    final currentFilter = context.watch<TransactionCubit>().state.currentFilter;
    final currentCardId = context.watch<TransactionCubit>().state.currentCardId;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _CardFilter(
            onPressed: () {
              context.read<TransactionCubit>().applyFilter(
                    TransactionFilter.all,
                    null,
                  );
            },
            isSelected: currentFilter == TransactionFilter.all,
            title: 'All',
          ),
        ),
        ...context.read<AppBloc>().state.user.cards.map(
              (card) => Expanded(
                child: _CardFilter(
                    onPressed: () {
                      context.read<TransactionCubit>().applyFilter(
                            TransactionFilter.userCards,
                            card.cardId,
                          );
                    },
                    isSelected: currentFilter == TransactionFilter.userCards &&
                        currentCardId == card.cardId,
                    title: '${card.cardId}'),
              ),
            ),
      ],
    );
  }
}

class _CardFilter extends StatelessWidget {
  const _CardFilter({
    required this.onPressed,
    required this.isSelected,
    required this.title,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? AppColors.red : Colors.transparent,
        ),
        child: Text(
          title,
          style: AppStyles.textStyle.copyWith(
            color: isSelected ? Colors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}

class _TransactionListContent extends StatelessWidget {
  const _TransactionListContent();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state.status == TransactionStatus.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.red,
              ),
            );
          } else {
            final transactions = state.filteredTransactions;
            return SingleChildScrollView(
              child: Column(
                children: transactions
                    .map(
                      (transaction) => Padding(
                        padding: EdgeInsets.only(
                          top: AppLayout.getHeight(15),
                          left: AppLayout.getWidth(15),
                          right: AppLayout.getWidth(15),
                        ),
                        child: SingleTransaction(
                          username: transaction.transactionId,
                          amount: transaction.amount,
                          color: context.read<AppBloc>().state.user.cards.any(
                                  (card) =>
                                      transaction.senderCardId == card.cardId)
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
