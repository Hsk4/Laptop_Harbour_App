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
          : ListView.builder(
              itemCount: wishlistProducts.length,
              itemBuilder: (context, index) {
                final laptop = wishlistProducts[index];
                return ListTile(
                  leading: laptop.imageUrl.isNotEmpty
                      ? Image.asset(laptop.imageUrl, width: 50, height: 50)
                      : const Icon(Icons.laptop),
                  title: Text(laptop.name),
                  subtitle: Text('Price: \$${laptop.price.toStringAsFixed(2)}'),
                  trailing: FavoriteButton(productId: laptop.id),
                );
              },
            ),
    );
  }
}
