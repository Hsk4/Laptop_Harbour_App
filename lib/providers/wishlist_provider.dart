import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
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
final wishlistBoxProvider = Provider<Box<List>>((ref) => Hive.box<List>('wishlistBox'));

final wishlistProductIdsProvider = StateNotifierProvider<WishlistNotifier, List<String>>((ref) {
  final userEmail = ref.watch(userEmailProvider);
  final repo = ref.watch(wishlistRepositoryProvider);
  final box = ref.watch(wishlistBoxProvider);
  return WishlistNotifier(userEmail, repo, box);
});

class WishlistNotifier extends StateNotifier<List<String>> {
  final String? userEmail;
  final WishlistRepository repo;
  final Box<List> box;

  WishlistNotifier(this.userEmail, this.repo, this.box) : super([]) {
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    if (userEmail == null) return;
    // Load from Hive first
    final cached = box.get(userEmail!);
    if (cached != null) {
      state = List<String>.from(cached);
    }
    // Then sync with Firestore
    final ids = await repo.getWishlist(userEmail!);
    state = ids;
    box.put(userEmail!, ids);
  }

  Future<void> addToWishlist(String productId) async {
    if (userEmail == null) return;
    await repo.addToWishlist(userEmail!, productId);
    final updated = [...state, productId];
    state = updated;
    box.put(userEmail!, updated);
  }

  Future<void> removeFromWishlist(String productId) async {
    if (userEmail == null) return;
    await repo.removeFromWishlist(userEmail!, productId);
    final updated = state.where((id) => id != productId).toList();
    state = updated;
    box.put(userEmail!, updated);
  }

  void clearWishlist() {
    if (userEmail == null) return;
    state = [];
    box.delete(userEmail!);
  }
}

final wishlistProductsProvider = Provider<List<Laptop>>((ref) {
  final productIds = ref.watch(wishlistProductIdsProvider);
  return laptops.where((laptop) => productIds.contains(laptop.id)).toList();
});
