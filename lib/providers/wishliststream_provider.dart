import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final wishlistStreamProvider = StreamProvider.autoDispose.family<List<String>, String>((ref, userEmail) {
  final wishlistCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('wishlist');

  return wishlistCollection.snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => doc.id).toList(),
  );
});

