import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import 'storage_repository.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser({
    required User user,
  }) async {
    String res = 'Some error occured';
    try {
      final String photoUrl = await StorageMethods().uploadImageToStorage(
        'user_photos',
        await loadImageBytes(user.photo!),
      );

      _firestore.collection('users').doc(user.id).set(
            user.copyWith(photo: photoUrl).toJson(),
          );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}

Future<Uint8List> loadImageBytes(String assetPath) async {
  final ByteData data = await rootBundle.load(assetPath);
  return data.buffer.asUint8List();
}
