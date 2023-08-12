import '../../models/transaction.dart';

enum TransactionStatus { loading, loaded }

class TransactionState {
  TransactionState({
    required this.transactions,
    required this.status,
  });

  factory TransactionState.loading() => TransactionState(
        transactions: [],
        status: TransactionStatus.loading,
      );
  final List<Transaction> transactions;
  final TransactionStatus status;
}
