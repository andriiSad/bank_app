import '../../models/transaction.dart';

enum TransactionStatus { loading, loaded }

enum TransactionFilter { all, userCards }

class TransactionState {
  TransactionState({
    required this.transactions,
    required this.status,
    this.currentFilter = TransactionFilter.all,
    this.currentCardId,
  });

  factory TransactionState.loading() => TransactionState(
        transactions: [],
        status: TransactionStatus.loading,
      );
  final List<Transaction> transactions;
  final TransactionStatus status;
  final TransactionFilter currentFilter;
  String? currentCardId;

  List<Transaction> get filteredTransactions {
    if (currentFilter == TransactionFilter.userCards && currentCardId != null) {
      return transactions
          .where((transaction) =>
              transaction.senderCardId == currentCardId ||
              transaction.receiverCardId == currentCardId)
          .toList();
    }
    return transactions;
  }

  TransactionState copyWith({
    List<Transaction>? transactions,
    TransactionStatus? status,
    TransactionFilter? currentFilter,
    String? currentCardId,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
      currentFilter: currentFilter ?? this.currentFilter,
      currentCardId: currentCardId ?? this.currentCardId,
    );
  }
}
