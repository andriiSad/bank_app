import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Transaction extends Equatable {
  const Transaction({
    required this.transactionId,
    required this.transactionDate,
    required this.senderCardId,
    required this.receiverCardId,
    required this.senderCardOwnerId,
    required this.recieverCardOwnerId,
    required this.amount,
  });

  factory Transaction.generateNew({
    required String senderCardId,
    required String receiverCardId,
    required String senderCardOwnerId,
    required String receiverCardOwnerId,
    required int amount,
  }) {
    final transactionId = const Uuid().v4();
    final transactionDate = DateTime.now();

    return Transaction(
      transactionId: transactionId,
      transactionDate: transactionDate,
      senderCardId: senderCardId,
      receiverCardId: receiverCardId,
      senderCardOwnerId: senderCardOwnerId,
      recieverCardOwnerId: receiverCardOwnerId,
      amount: amount,
    );
  }

  factory Transaction.fromSnap(DocumentSnapshot snap) {
    final data = snap.data()! as Map<String, dynamic>;

    return Transaction(
      transactionId: data['transactionId'] as String,
      transactionDate: (data['transactionDate'] as Timestamp).toDate(),
      senderCardId: data['senderCardId'] as String,
      receiverCardId: data['receiverCardId'] as String,
      senderCardOwnerId: data['senderCardOwnerId'] as String,
      recieverCardOwnerId: data['receiverCardOwnerId'] as String,
      amount: data['amount'] as int,
    );
  }

  final String transactionId;
  final DateTime transactionDate;
  final String senderCardId;
  final String receiverCardId;
  final String senderCardOwnerId;
  final String recieverCardOwnerId;

  final int amount;

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'transactionDate': Timestamp.fromDate(transactionDate),
      'senderCardId': senderCardId,
      'receiverCardId': receiverCardId,
      'senderCardOwnerId': senderCardOwnerId,
      'receiverCardOwnerId': recieverCardOwnerId,
      'amount': amount,
    };
  }

  Transaction copyWith({
    String? transactionId,
    DateTime? transactionDate,
    String? senderCardId,
    String? receiverCardId,
    String? senderCardOwnerId,
    String? recieverCardOwnerId,
    int? amount,
  }) {
    return Transaction(
      transactionId: transactionId ?? this.transactionId,
      transactionDate: transactionDate ?? this.transactionDate,
      senderCardId: senderCardId ?? this.senderCardId,
      receiverCardId: receiverCardId ?? this.receiverCardId,
      senderCardOwnerId: senderCardOwnerId ?? this.senderCardOwnerId,
      recieverCardOwnerId: recieverCardOwnerId ?? this.recieverCardOwnerId,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [
        transactionId,
        transactionDate,
        senderCardId,
        receiverCardId,
        senderCardOwnerId,
        recieverCardOwnerId,
        amount,
      ];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'Transaction(transactionId: $transactionId, transactionDate: $transactionDate, senderCardId: $senderCardId, receiverCardId: $receiverCardId, senderCardOwnerId: $senderCardOwnerId, recieverCardOwnerId: $recieverCardOwnerId, amount: $amount)';
  }
}
