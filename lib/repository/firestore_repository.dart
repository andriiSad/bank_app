import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import 'storage_repository.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> createUser({
    required User user,
    required Uint8List file,
  }) async {
    try {
      final String photoUrl = await _storageMethods.uploadImageToStorage(
        'user_photos',
        file,
      );
      await _firestore.collection('users').doc(user.id).set(
            user.copyWith(photo: photoUrl).toJson(),
          );

      return 'success';
    } catch (e) {
      return 'Error: Unable to create user - $e';
    }
  }

  Future<User?> getUserById(String id) async {
    final DocumentSnapshot snap =
        await _firestore.collection('users').doc(id).get();
    return !snap.exists ? null : User.fromSnap(snap);
  }
}
