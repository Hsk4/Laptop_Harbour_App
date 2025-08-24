import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_item.dart';
import '../../providers/order_provider.dart';
import '../../models/order_model.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ordeplaced_page.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final total = cart.fold<double>(0, (sum, item) => sum + item.laptop.price * item.quantity);

    if (cart.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: const Center(child: Text('Your cart is empty.')),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: ListView.separated(
          itemCount: cart.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = cart[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: item.laptop.imageUrl.isNotEmpty
                      ? Image.asset(item.laptop.imageUrl, width: 56, height: 56, fit: BoxFit.cover)
                      : const Icon(Icons.laptop, size: 40),
                ),
                title: Text(item.laptop.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: ₹${item.laptop.price.toStringAsFixed(2)}'),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: item.quantity > 1
                              ? () => cartNotifier.updateQuantity(item.laptop.id, item.quantity - 1)
                              : null,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => cartNotifier.updateQuantity(item.laptop.id, item.quantity + 1),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => cartNotifier.removeFromCart(item.laptop.id),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: ₹${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () async {
                  final addressController = TextEditingController();
                  String paymentMethod = 'Cash on Delivery';
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 24,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Order Summary',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            ...cart.map((item) => ListTile(
                              title: Text(item.laptop.name),
                              subtitle: Text('x${item.quantity}'),
                              trailing: Text(
                                  '₹${(item.laptop.price * item.quantity).toStringAsFixed(2)}'),
                            )),
                            const Divider(),
                            Text('Total: ₹${total.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            TextField(
                              controller: addressController,
                              decoration: const InputDecoration(
                                labelText: 'Delivery Address',
                                border: OutlineInputBorder(),
                              ),
                              minLines: 2,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              value: paymentMethod,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Cash on Delivery', child: Text('Cash on Delivery')),
                                DropdownMenuItem(value: 'Credit Card', child: Text('Credit Card')),
                                DropdownMenuItem(value: 'UPI', child: Text('UPI')),
                              ],
                              onChanged: (val) {
                                if (val != null) paymentMethod = val;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Payment Method',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    if (addressController.text.trim().isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Please enter address')));
                                      return;
                                    }
                                    final user = FirebaseAuth.instance.currentUser;
                                    if (user == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('User not logged in')));
                                      return;
                                    }
                                    final orderId = const Uuid().v4();
                                    final order = Order(
                                      id: orderId,
                                      userId: user.uid,
                                      items: List.from(cart),
                                      total: total,
                                      address: addressController.text.trim(),
                                      paymentMethod: paymentMethod,
                                      timestamp: DateTime.now(),
                                    );
                                    debugPrint('Placing order: \n$order');

                                    await ref.read(orderProvider.notifier).addOrder(order);
                                    cartNotifier.clearCart();

                                    // ✅ Close bottom sheet
                                    Navigator.of(context).pop();

                                    // ✅ Navigate to OrderPlacedScreen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => OrderPlacedScreen(order: order),
                                      ),
                                    );
                                  } catch (e, st) {
                                    debugPrint('Error placing order: $e\n$st');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error placing order: $e')),
                                    );
                                  }
                                },
                                child: const Text('Place Order'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
