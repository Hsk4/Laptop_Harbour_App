import 'package:hive/hive.dart';
import 'Laptop_model.dart';

part 'Laptop_model.g.dart';

@HiveType(typeId: 0)
class Laptop extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String brand;
  @HiveField(5)
  final String imageUrl;
  @HiveField(6)
  final double price;

  Laptop({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.imageUrl,
    required this.price,
  });

  factory Laptop.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return Laptop(
      id: documentId ?? map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      brand: map['brand'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }
}

