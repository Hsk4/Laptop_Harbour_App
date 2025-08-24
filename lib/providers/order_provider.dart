import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import '../models/order_model.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, List<Order>>((ref) => OrderNotifier());

class OrderNotifier extends StateNotifier<List<Order>> {
  OrderNotifier() : super([]);

  Future<void> fetchOrders(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    final orders = snapshot.docs.map((doc) => Order.fromMap(doc.data())).toList();
    state = orders;
  }

  Future<void> addOrder(Order order) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(order.id)
        .set(order.toMap());

    // ✅ Immediately update local state so UI refreshes without waiting
    state = [order, ...state];

    // ✅ Also refresh from Firestore to stay in sync
    await fetchOrders(order.userId);
  }
}
