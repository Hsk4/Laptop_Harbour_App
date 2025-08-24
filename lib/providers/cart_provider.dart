import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../models/cart_item.dart';
import 'user_provider.dart';

final cartBoxProvider = Provider<Box<CartItem>>((ref) => Hive.box<CartItem>('cartBox'));

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  final userEmail = ref.watch(userEmailProvider);
  final box = ref.watch(cartBoxProvider);
  return CartNotifier(ref, userEmail, box);
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  final Ref ref;
  final String? userEmail;
  final Box<CartItem> box;
  CartNotifier(this.ref, this.userEmail, this.box) : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    if (userEmail == null) return;
    // Load from Hive first
    final cached = box.values.where((item) => item.key == userEmail).toList();
    if (cached.isNotEmpty) {
      state = List<CartItem>.from(cached);
    }
    // Then sync with Firestore
    final doc = await FirebaseFirestore.instance.collection('carts').doc(userEmail).get();
    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      final items = (data['items'] as List<dynamic>? ?? [])
          .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
          .toList();
      state = items;
      // Save to Hive
      await box.clear();
      for (var item in items) {
        await box.add(item);
      }
    } else {
      state = [];
    }
  }

  Future<void> _saveCart() async {
    if (userEmail == null) return;
    await FirebaseFirestore.instance.collection('carts').doc(userEmail).set({
      'items': state.map((item) => item.toMap()).toList(),
    });
    // Save to Hive
    await box.clear();
    for (var item in state) {
      await box.add(item);
    }
  }

  void addToCart(CartItem item) {
    final index = state.indexWhere((i) => i.laptop.id == item.laptop.id);
    if (index == -1) {
      state = [...state, item];
    } else {
      final updated = [...state];
      final old = updated[index];
      updated[index] = CartItem(laptop: old.laptop, quantity: old.quantity + item.quantity);
      state = updated;
    }
    _saveCart();
  }

  void removeFromCart(String laptopId) {
    state = state.where((item) => item.laptop.id != laptopId).toList();
    _saveCart();
  }

  void updateQuantity(String laptopId, int quantity) {
    final index = state.indexWhere((item) => item.laptop.id == laptopId);
    if (index != -1) {
      final updated = [...state];
      final old = updated[index];
      updated[index] = CartItem(laptop: old.laptop, quantity: quantity);
      state = updated;
      _saveCart();
    }
  }

  void clearCart() {
    state = [];
    _saveCart();
  }
}
