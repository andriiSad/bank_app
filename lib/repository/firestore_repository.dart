import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import 'storage_repository.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> createUser({
    required User user,
  }) async {
    try {
      final String photoUrl = await _storageMethods.uploadImageToStorage(
        'user_photos',
        await loadImageBytes(user.photo!),
      );

      await _firestore.collection('users').doc(user.id).set(
            user.copyWith(photo: photoUrl).toJson(),
          );

      return 'success'; // Indicate success by returning a specific string.
    } catch (e) {
      return e.toString(); // Return the error message in case of failure.
    }
  }

  Future<User?> getUserById(String id) async {
    final DocumentSnapshot snap =
        await _firestore.collection('users').doc(id).get();
    return !snap.exists ? null : User.fromSnap(snap);
  }
}

Future<Uint8List> loadImageBytes(String assetPath) async {
  final ByteData data = await rootBundle.load(assetPath);
  return data.buffer.asUint8List();
}
