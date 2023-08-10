import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum CreditCardType {
  premium,
  platinum,
}

extension CreditCardTypeExtension on CreditCardType {
  String toStringValue() {
    switch (this) {
      case CreditCardType.premium:
        return 'Premium';
      case CreditCardType.platinum:
        return 'Platinum';
    }
  }
}

class CreditCard extends Equatable {
  const CreditCard({
    this.cardId,
    required this.ownerId,
    required this.balance,
    required this.type,
  });

  factory CreditCard.fromSnap(DocumentSnapshot snap) {
    final data = snap.data()! as Map<String, dynamic>;

    return CreditCard(
      cardId: data['cardId'] as String?,
      ownerId: data['ownerId'] as String,
      balance: data['balance'] as int,
      type: CreditCardType.values[data['type'] as int],
    );
  }

  factory CreditCard.generateNew({
    required String ownerId,
    required int balance,
    required CreditCardType type,
  }) {
    final random = Random();
    const int min = 0;
    const int max = 9999;
    final int randomNum = min + random.nextInt(max - min + 1);
    final cardId = randomNum.toString().padLeft(4, '0');
    return CreditCard(
      cardId: cardId,
      ownerId: ownerId,
      balance: balance,
      type: type,
    );
  }

  final String? cardId;
  final String ownerId;
  final CreditCardType type;
  final int balance;

  static const empty = CreditCard(
    cardId: '',
    ownerId: '',
    balance: 0,
    type: CreditCardType.premium,
  );

  bool get isEmpty => this == CreditCard.empty;

  bool get isNotEmpty => this != CreditCard.empty;

  @override
  List<Object?> get props => [cardId, ownerId, balance];

  Map<String, dynamic> toJson() {
    return {
      'cardId': cardId,
      'ownerId': ownerId,
      'balance': balance,
      'type': type.index,
    };
  }

  @override
  String toString() {
    return 'CreditCard(cardId: $cardId, ownerId: $ownerId, balance: $balance, type: $type)';
  }

  CreditCard copyWith({
    String? cardId,
    String? ownerId,
    int? balance,
    CreditCardType? type,
  }) {
    return CreditCard(
      cardId: cardId ?? this.cardId,
      ownerId: ownerId ?? this.ownerId,
      balance: balance ?? this.balance,
      type: type ?? this.type,
    );
  }
}
