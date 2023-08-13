import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart'; // Import the rxdart package

import '../models/credit_card.dart';
import '../models/transaction.dart' as custom_transaction;
import '../models/user.dart';
import 'storage_repository.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> createUser({
    required User user,
    required List<CreditCard> cards,
    required Uint8List? file,
  }) async {
    try {
      for (final card in cards) {
        await _firestore.collection('cards').doc(card.cardId).set(card.toJson());
      }
      if (file == null) {
        await _firestore.collection('users').doc(user.id).set(
              user.toJson(),
            );
      } else {
        final String photoUrl = await _storageMethods.uploadImageToStorage(
          'user_photos',
          file,
        );
        await _firestore.collection('users').doc(user.id).set(
              user.copyWith(photoUrl: photoUrl).toJson(),
            );
      }

      return 'success';
    } catch (e) {
      return 'Error: Unable to create user - $e';
    }
  }

  Future<String> updateUserProfilePhoto({
    required String userId,
    required Uint8List file,
  }) async {
    try {
      final String photoUrl = await _storageMethods.uploadImageToStorage(
        'user_photos',
        file,
      );
      await _firestore.collection('users').doc(userId).update({
        'photoUrl': photoUrl,
      });

      return 'success';
    } catch (e) {
      return 'Error: Unable to update user profile photo - $e';
    }
  }

  Future<void> changePassword(String userId, String newPassword) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'password': newPassword, // Replace with the actual field name
      });
    } catch (e) {
      throw Exception('Error changing password: $e');
    }
  }

  Future<User> getUserById(String id) async {
    const maxRetries = 100;
    var retries = 0;

    while (retries < maxRetries) {
      final userSnap = await _firestore.collection('users').doc(id).get();

      if (userSnap.exists) {
        var user = User.fromSnap(userSnap);

        final cardList = await getCardListByOwnerId(id);
        user = user.copyWith(cards: cardList);

        return user;
      }

      retries++;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    throw Exception('User with ID $id not found after $maxRetries attempts');
  }

  //gets all cards that related to current user
  Future<List<CreditCard>> getCardListByOwnerId(String ownerId) async {
    const maxRetries = 10;
    var retries = 0;

    while (retries < maxRetries) {
      final cardsSnap = await _firestore.collection('cards').where('ownerId', isEqualTo: ownerId).get();

      final cardList = cardsSnap.docs.map((cardSnap) {
        return CreditCard.fromSnap(cardSnap);
      }).toList();

      if (cardList.isNotEmpty) {
        return cardList;
      }

      retries++;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    throw Exception('Unable to fetch card list for ownerId $ownerId after $maxRetries attempts');
  }

  //gets all cards, without user's cards
  Future<List<CreditCard>> getAllCardsList(String ownerId) async {
    const maxRetries = 5;
    var retries = 0;

    while (retries < maxRetries) {
      final cardsSnap = await _firestore.collection('cards').where('ownerId', isNotEqualTo: ownerId).get();

      final cardList = cardsSnap.docs.map((cardSnap) {
        return CreditCard.fromSnap(cardSnap);
      }).toList();

      if (cardList.isNotEmpty) {
        return cardList;
      }

      retries++;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    throw Exception('Unable to fetch card list after $maxRetries attempts');
  }

  Future<User?> getUserByCardId(String cardId) async {
    try {
      final cardSnap = await _firestore.collection('cards').doc(cardId).get();

      if (cardSnap.exists) {
        final cardData = cardSnap.data();
        final ownerId = cardData?['ownerId'] as String?;

        if (ownerId != null) {
          final userSnap = await _firestore.collection('users').doc(ownerId).get();

          if (userSnap.exists) {
            return User.fromSnap(userSnap);
          }
        }
      }

      return null; // Return null if card or user doesn't exist
    } catch (e) {
      return null; // Handle the error gracefully
    }
  }

  Future<List<custom_transaction.Transaction>> getTransactions(String userId) async {
    try {
      final receiverTransactionsSnap =
          await _firestore.collection('transactions').where('receiverCardOwnerId', isEqualTo: userId).get();

      final senderTransactionsSnap =
          await _firestore.collection('transactions').where('senderCardOwnerId', isEqualTo: userId).get();

      final transactionList = [
        ...receiverTransactionsSnap.docs,
        ...senderTransactionsSnap.docs,
      ].map((transactionSnap) {
        return custom_transaction.Transaction.fromSnap(transactionSnap);
      }).toList();

      return transactionList;
    } catch (e) {
      print('Error getting transactions for user ID $userId: $e');
      return [];
    }
  }

  Future<void> sendMoney({
    required String senderCardId,
    required String receiverCardId,
    required int amount,
  }) async {
    try {
      final senderCardRef = _firestore.collection('cards').doc(senderCardId);
      final receiverCardRef = _firestore.collection('cards').doc(receiverCardId);

      final senderCardSnap = await senderCardRef.get();
      final receiverCardSnap = await receiverCardRef.get();

      if (senderCardSnap.exists && receiverCardSnap.exists) {
        final senderCard = CreditCard.fromSnap(senderCardSnap);
        final receiverCard = CreditCard.fromSnap(receiverCardSnap);

        if (senderCard.balance >= amount) {
          final String senderCardOwnerId = senderCard.ownerId;
          final String receiverCardOwnerId = receiverCard.ownerId;

          final transaction = custom_transaction.Transaction.generateNew(
            senderCardId: senderCardId,
            receiverCardId: receiverCardId,
            senderCardOwnerId: senderCardOwnerId,
            receiverCardOwnerId: receiverCardOwnerId,
            amount: amount,
          );

          // Update sender's balance
          await senderCardRef.update({
            'balance': senderCard.balance - amount,
          });

          // Update receiver's balance
          await receiverCardRef.update({
            'balance': receiverCard.balance + amount,
          });

          // Add the transaction to the transactions collection
          await _firestore.collection('transactions').doc(transaction.transactionId).set(transaction.toJson());
        } else {
          throw const SendMoneyFailure('Insufficient funds');
        }
      } else {
        throw const SendMoneyFailure('Invalid card IDs');
      }
    } on SendMoneyFailure catch (e) {
      throw SendMoneyFailure(e.message);
    } catch (_) {
      throw const SendMoneyFailure();
    }
  }

  Stream<List<custom_transaction.Transaction>> getTransactionsStream(String userId) {
    final receiverTransactionsStream = _firestore
        .collection('transactions')
        .where('receiverCardOwnerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => _mapTransactionSnapshots(snapshot.docs));

    final senderTransactionsStream = _firestore
        .collection('transactions')
        .where('senderCardOwnerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => _mapTransactionSnapshots(snapshot.docs));

    final mergedStream = Rx.merge([receiverTransactionsStream, senderTransactionsStream]);

    // Sort the merged stream by transactionDate in descending order
    final sortedStream = mergedStream.map((transactions) {
      transactions.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
      return transactions;
    });

    return sortedStream;
  }

  List<custom_transaction.Transaction> _mapTransactionSnapshots(List<QueryDocumentSnapshot> snapshots) {
    return snapshots.map((snapshot) {
      return custom_transaction.Transaction.fromSnap(snapshot);
    }).toList();
  }
}

class SendMoneyFailure implements Exception {
  const SendMoneyFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// The associated error message.
  final String message;
}
