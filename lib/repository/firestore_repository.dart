import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadUserPhoto({
    required Uint8List file,
    required String uid,
    required String username,
    required String profImage,
  }) async {
    String res = 'Some error occured';
    try {
      // final String photoUrl =
      //     await StorageMethods().uploadImageToStorage('posts', file, true);

      // _firestore.collection('user_photos').doc(uid).set(
      //       post.toJson(),
      //     );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
