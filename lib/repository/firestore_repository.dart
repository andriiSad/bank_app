import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/credit_card.dart';
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
        await _firestore
            .collection('cards')
            .doc(card.cardId)
            .set(card.toJson());
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
      // Implement the logic to update the user's password in Firestore
      // This may involve using Firebase Authentication or a custom solution
      // For this example, I'm using a placeholder function
      await _firestore.collection('users').doc(userId).update({
        'password': newPassword, // Replace with the actual field name
      });
    } catch (e) {
      throw Exception('Error changing password: $e');
    }
  }

  Future<User> getUserById(String id) async {
    const maxRetries = 10;
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
      final cardsSnap = await _firestore
          .collection('cards')
          .where('ownerId', isEqualTo: ownerId)
          .get();

      final cardList = cardsSnap.docs.map((cardSnap) {
        return CreditCard.fromSnap(cardSnap);
      }).toList();

      if (cardList.isNotEmpty) {
        return cardList;
      }

      retries++;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    throw Exception(
        'Unable to fetch card list for ownerId $ownerId after $maxRetries attempts');
  }

  //gets all cards, without user's cards
  Future<List<CreditCard>> getAllCardsList(String ownerId) async {
    const maxRetries = 5;
    var retries = 0;

    while (retries < maxRetries) {
      final cardsSnap = await _firestore
          .collection('cards')
          .where('ownerId', isNotEqualTo: ownerId)
          .get();

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
}
