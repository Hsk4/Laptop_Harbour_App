import 'package:flutter/material.dart';
import '../../models/Laptop_model.dart';
import '../../pages/Dashboard_pages/product_details_page.dart';
import '../general_components/favourite_component.dart';


class LaptopGridView extends StatelessWidget {
  final List<Laptop> laptops;

  const LaptopGridView({super.key, required this.laptops});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 4,
      ),
      itemCount: laptops.length,
      itemBuilder: (context, index) {
        final laptop = laptops[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(laptop: laptop, index: index),
              ),
            );
          },
          child: Card(
            elevation: 2,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: laptop.imageUrl.isNotEmpty
                          ? Image.asset(laptop.imageUrl,
                              fit: BoxFit.cover, width: double.infinity)
                          : const Icon(Icons.laptop, size: 80),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        laptop.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '\$${laptop.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: FavoriteButton(productId: laptop.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
