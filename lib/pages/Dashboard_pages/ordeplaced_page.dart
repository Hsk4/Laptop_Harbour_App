import 'package:flutter/material.dart';
import '../../models/order_model.dart';

class OrderPlacedScreen extends StatelessWidget {
  final Order order;

  const OrderPlacedScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Placed")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.check_circle, color: Colors.green, size: 100),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Your order has been placed!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Text("🆔 Order ID: ${order.id}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("💰 Total: ₹${order.total.toStringAsFixed(2)}"),
            Text("📦 Items: ${order.items.length}"),
            Text("📍 Address: ${order.address}"),
            Text("💳 Payment: ${order.paymentMethod}"),
            Text("📅 Date: ${order.timestamp}"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to orders / home
                },
                child: const Text("Back to Orders"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
