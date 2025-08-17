import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/general_components/favourite_component.dart';
import '../../models/Laptop_model.dart';
import '../../providers/cart_provider.dart';


class ProductDetailsPage extends ConsumerStatefulWidget {
  final Laptop laptop;
  final int index;
  const ProductDetailsPage({Key? key, required this.laptop, required this.index}) : super(key: key);

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.laptop.name),
        actions: [
          FavoriteButton(productId: widget.laptop.id),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: widget.laptop.imageUrl.isNotEmpty
                  ? Image.asset(
                      widget.laptop.imageUrl,
                      height: 200,
                    )
                  : const Icon(Icons.laptop, size: 120),
            ),
            const SizedBox(height: 16),
            Text(widget.laptop.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.laptop.description),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: quantity > 1 ? () => setState(() => quantity--) : null,
                ),
                Text('$quantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => quantity++),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).addToCart(widget.laptop, quantity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart!')),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
