import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import 'storage_repository.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> createUser({
    required User user,
    required Uint8List? file,
  }) async {
    try {
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

  Future<User> getUserById(String id) async {
    const maxRetries = 10;
    var retries = 0;

    while (retries < maxRetries) {
      final snap = await _firestore.collection('users').doc(id).get();

      if (snap.exists) {
        return User.fromSnap(snap);
      }

      retries++;
      await Future.delayed(const Duration(milliseconds: 500));
    }

    throw Exception('User with ID $id not found after $maxRetries attempts');
  }
}
