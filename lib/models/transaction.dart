import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Transaction extends Equatable {
  const Transaction({
    required this.transactionId,
    required this.transactionDate,
    required this.ownerCardId,
    required this.receiverCardId,
    required this.amount,
  });

  factory Transaction.generateNew({
    required String ownerCardId,
    required String receiverCardId,
    required int amount,
  }) {
    final transactionId = const Uuid().v4();
    final transactionDate = DateTime.now();

    return Transaction(
      transactionId: transactionId,
      transactionDate: transactionDate,
      ownerCardId: ownerCardId,
      receiverCardId: receiverCardId,
      amount: amount,
    );
  }

  factory Transaction.fromSnap(DocumentSnapshot snap) {
    final data = snap.data()! as Map<String, dynamic>;

    return Transaction(
      transactionId: data['transactionId'] as String,
      transactionDate: (data['transactionDate'] as Timestamp).toDate(),
      ownerCardId: data['ownerCardId'] as String,
      receiverCardId: data['receiverCardId'] as String,
      amount: data['amount'] as int,
    );
  }

  final String transactionId;
  final DateTime transactionDate;
  final String ownerCardId;
  final String receiverCardId;
  final int amount;

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'transactionDate': Timestamp.fromDate(transactionDate),
      'ownerCardId': ownerCardId,
      'receiverCardId': receiverCardId,
      'amount': amount,
    };
  }

  Transaction copyWith({
    String? transactionId,
    DateTime? transactionDate,
    String? ownerCardId,
    String? receiverCardId,
    int? amount,
  }) {
    return Transaction(
      transactionId: transactionId ?? this.transactionId,
      transactionDate: transactionDate ?? this.transactionDate,
      ownerCardId: ownerCardId ?? this.ownerCardId,
      receiverCardId: receiverCardId ?? this.receiverCardId,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props =>
      [transactionId, transactionDate, ownerCardId, receiverCardId, amount];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'Transaction(transactionId: $transactionId, transactionDate: $transactionDate, ownerCardId: $ownerCardId, receiverCardId: $receiverCardId, amount: $amount)';
  }
}
