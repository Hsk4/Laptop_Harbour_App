import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../providers/user_provider.dart';
import '../../providers/wishlist_provider.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

class FavoriteButton extends ConsumerWidget {
  final String productId;

  const FavoriteButton({required this.productId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(userEmailProvider);
    final wishlistAsync = ref.watch(wishlistProductIdsProvider);
    final repo = ref.read(wishlistRepositoryProvider);

    if (userEmail == null) {
      return IconButton(
        icon: const Icon(Icons.favorite_border, color: Colors.grey),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please login to add favorites')),
          );
        },
      );
    }

    return wishlistAsync.when(
      data: (wishlist) {
        final isFav = wishlist.contains(productId);
        return IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : Colors.grey),
          onPressed: () async {
            if (isFav) {
              await repo.removeFromWishlist(userEmail, productId);
              ref.refresh(wishlistProductIdsProvider);
            } else {
              await repo.addToWishlist(userEmail, productId);
              ref.refresh(wishlistProductIdsProvider);
            }
          },
        );
      },
      loading: () => const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
      error: (e, _) => const Icon(Icons.error),
    );
  }
}
