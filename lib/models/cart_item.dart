import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Laptop_model.dart';

class CartItem {
  final Laptop laptop;
  int quantity;

  CartItem({required this.laptop, required this.quantity});

  Map<String, dynamic> toMap() => {
        'laptop': {
          'id': laptop.id,
          'name': laptop.name,
          'description': laptop.description,
          'category': laptop.category,
          'brand': laptop.brand,
          'imageUrl': laptop.imageUrl,
          'price': laptop.price,
        },
        'quantity': quantity,
      };

  factory CartItem.fromMap(Map<String, dynamic> map) => CartItem(
        laptop: Laptop.fromMap(map['laptop'] as Map<String, dynamic>),
        quantity: map['quantity'] ?? 1,
      );
}
