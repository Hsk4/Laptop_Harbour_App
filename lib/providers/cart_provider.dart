import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_item.dart';
import '../models/Laptop_model.dart';
import 'user_provider.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  final Ref ref;
  CartNotifier(this.ref) : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final userEmail = ref.read(userEmailProvider);
    if (userEmail == null) return;
    // Firestore security rules should ensure only the authenticated user can read their own cart
    final doc = await FirebaseFirestore.instance.collection('carts').doc(userEmail).get();
    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      final items = (data['items'] as List<dynamic>? ?? [])
          .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
          .toList();
      state = items;
    } else {
      state = [];
    }
  }

  Future<void> _saveCart() async {
    final userEmail = ref.read(userEmailProvider);
    if (userEmail == null) return;
    await FirebaseFirestore.instance.collection('carts').doc(userEmail).set({
      'items': state.map((item) => item.toMap()).toList(),
    });
  }

  @override
  set state(List<CartItem> value) {
    super.state = value;
    _saveCart();
  }

  void addToCart(Laptop laptop, int quantity) {
    final index = state.indexWhere((item) => item.laptop.id == laptop.id);
    if (index != -1) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            CartItem(laptop: laptop, quantity: state[i].quantity + quantity)
          else
            state[i]
      ];
    } else {
      state = [...state, CartItem(laptop: laptop, quantity: quantity)];
    }
  }

  void removeFromCart(String laptopId) {
    state = state.where((item) => item.laptop.id != laptopId).toList();
  }

  void updateQuantity(String laptopId, int quantity) {
    state = [
      for (final item in state)
        if (item.laptop.id == laptopId)
          CartItem(laptop: item.laptop, quantity: quantity)
        else
          item
    ];
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier(ref));
