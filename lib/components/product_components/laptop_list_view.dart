import 'package:flutter/material.dart';
import '../../models/Laptop_model.dart';

class LaptopListView extends StatelessWidget {
  final List<Laptop> laptops;

  const LaptopListView({super.key, required this.laptops});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      itemCount: laptops.length,
      itemBuilder: (context, index) {
        final laptop = laptops[index];
        return Card(
          elevation: 4, // Adds shadow for the modern look
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: laptop.imageUrl.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                laptop.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            )
                : const Icon(Icons.laptop, size: 60, color: Colors.grey),
            title: Text(
              laptop.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              laptop.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              '\$${laptop.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            onTap: () {
              // Optional: handle tap event, e.g., navigate to details page
            },
          ),
        );
      },
    );
  }
}
