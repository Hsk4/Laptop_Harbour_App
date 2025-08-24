import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/general_components/favourite_component.dart';
import '../../providers/wishlist_provider.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final wishlistProducts = ref.watch(wishlistProductsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Wishlist')),
      body: wishlistProducts.isEmpty
          ? const Center(child: Text('Your wishlist is empty'))
          : ListView.separated(
              itemCount: wishlistProducts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final laptop = wishlistProducts[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: laptop.imageUrl.isNotEmpty
                          ? Image.asset(laptop.imageUrl, width: 56, height: 56, fit: BoxFit.cover)
                          : const Icon(Icons.laptop, size: 40),
                    ),
                    title: Text(laptop.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Price:  \\${laptop.price.toStringAsFixed(2)}'),
                    trailing: FavoriteButton(productId: laptop.id),
                  ),
                );
              },
            ),
    );
  }
}
