import 'package:equatable/equatable.dart';

enum TransferError { none, insufficientFunds, connectionError, other }

class TransferStates extends Equatable {
  const TransferStates({
    this.senderCardId = '',
    this.receiverCardId = '',
    this.amount = 0,
    this.loading = false,
    this.error = TransferError.none,
  });

  final String senderCardId;
  final String receiverCardId;
  final int amount;
  final bool loading;
  final TransferError error;

  @override
  List<Object?> get props => [
        senderCardId,
        receiverCardId,
        amount,
        loading,
        error,
      ];

  TransferStates copyWith({
    String? senderCardId,
    String? receiverCardId,
    int? amount,
    bool? loading,
    TransferError? error,
  }) {
    return TransferStates(
      senderCardId: senderCardId ?? this.senderCardId,
      receiverCardId: receiverCardId ?? this.receiverCardId,
      amount: amount ?? this.amount,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
