import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/cart_provider.dart';
import '../../models/cart_item.dart';

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
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final item = cart[index];
          return ListTile(
            leading: item.laptop.imageUrl.isNotEmpty
                ? Image.asset(item.laptop.imageUrl, width: 50, height: 50)
                : const Icon(Icons.laptop),
            title: Text(item.laptop.name),
            subtitle: Text('Price: \$${item.laptop.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: item.quantity > 1
                      ? () => cartNotifier.updateQuantity(item.laptop.id, item.quantity - 1)
                      : null,
                ),
                Text('${item.quantity}'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => cartNotifier.updateQuantity(item.laptop.id, item.quantity + 1),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => cartNotifier.removeFromCart(item.laptop.id),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                cartNotifier.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed!')));
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
