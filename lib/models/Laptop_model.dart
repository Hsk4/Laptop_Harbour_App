class Laptop {
  final String id;
  final String name;
  final String description;
  final String category;
  final String brand;
  final String imageUrl;
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
