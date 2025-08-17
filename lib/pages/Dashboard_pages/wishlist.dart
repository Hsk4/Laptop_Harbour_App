import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/general_components/favourite_component.dart';
import '../../providers/wishlist_provider.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistProductsAsync = ref.watch(wishlistProductsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Wishlist')),
      body: wishlistProductsAsync.when(
        data: (laptops) {
          if (laptops.isEmpty) {
            return const Center(child: Text('Your wishlist is empty'));
          }
          return ListView.builder(
            itemCount: laptops.length,
            itemBuilder: (context, index) {
              final laptop = laptops[index];
              return ListTile(
                leading: laptop.imageUrl.isNotEmpty
                    ? Image.asset(laptop.imageUrl, width: 60, height: 60, fit: BoxFit.cover)
                    : const Icon(Icons.laptop),
                title: Text(laptop.name),
                subtitle: Text(
                  laptop.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: FavoriteButton(productId: laptop.id),
                onTap: () {
                  // Optional: navigate to product detail page
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
