import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/general_components/favourite_component.dart';
import 'user_provider.dart';
import '../data/laptop_data.dart'; // Your hardcoded laptops list
import '../models/Laptop_model.dart';

class WishlistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getWishlist(String userEmail) async {
    final doc = await _firestore.collection('wishlists').doc(userEmail).get();
    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      final ids = List<String>.from(data['productIds'] ?? []);
      return ids;
    }
    return [];
  }

  Future<void> addToWishlist(String userEmail, String productId) async {
    final ref = _firestore.collection('wishlists').doc(userEmail);
    await ref.set({
      'productIds': FieldValue.arrayUnion([productId])
    }, SetOptions(merge: true));
  }

  Future<void> removeFromWishlist(String userEmail, String productId) async {
    final ref = _firestore.collection('wishlists').doc(userEmail);
    await ref.set({
      'productIds': FieldValue.arrayRemove([productId])
    }, SetOptions(merge: true));
  }
}

final wishlistRepositoryProvider = Provider((ref) => WishlistRepository());

final wishlistProductIdsProvider = FutureProvider<List<String>>((ref) async {
  final userEmail = ref.watch(userEmailProvider);
  if (userEmail == null) return [];
  final repo = ref.watch(wishlistRepositoryProvider);
  return await repo.getWishlist(userEmail);
});

final wishlistProductsProvider = FutureProvider<List<Laptop>>((ref) async {
  final productIds = await ref.watch(wishlistProductIdsProvider.future);
  if (productIds.isEmpty) return [];
  return laptops.where((laptop) => productIds.contains(laptop.id)).toList();
});
