class Laptop {
  final String id;
  final String name;
  final String imageUrl; // local asset path or network URL
  final String description;
  final double price;
  final String brand;
  final String category; // e.g., 'Gaming', 'Office', etc.

  Laptop({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.category,
    required this.brand,

  });
}
