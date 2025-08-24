import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'cart_item.dart';

part 'order_model.g.dart';

@HiveType(typeId: 3)
class Order {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final List<CartItem> items;
  @HiveField(3)
  final double total;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String paymentMethod;
  @HiveField(6)
  final DateTime timestamp;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.address,
    required this.paymentMethod,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((e) => e.toMap()).toList(),
      'total': total,
      'address': address,
      'paymentMethod': paymentMethod,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['userId'],
      items: (map['items'] as List).map((e) => CartItem.fromMap(e)).toList(),
      total: map['total'],
      address: map['address'],
      paymentMethod: map['paymentMethod'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }
}
