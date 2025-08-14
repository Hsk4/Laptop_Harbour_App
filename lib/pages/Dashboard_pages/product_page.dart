import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/Laptop_model.dart';
import '../../providers/category_provider.dart';
import '../../providers/selected_provider.dart';
import '../../providers/viewtype_provider.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key});

  static const brandOptions = [
    'All',
    'Dell',
    'HP',
    'Apple',
    'Acer',
    // Add your brands here
  ];

  static const allCategoriesWithAll = [
    'All',
    'Gaming',
    'Office',
    'Workstation',
    'Chromebooks',
    'MacBooks',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final selectedBrand = ref.watch(selectedBrandProvider);
    final viewType = ref.watch(viewTypeProvider);
    final laptops = ref.watch(filteredLaptopsProvider);

    void updateCategory(String category) {
      if (category == 'All') {
        ref.read(selectedCategoryProvider.notifier).state = null;
      } else {
        ref.read(selectedCategoryProvider.notifier).state = category;
      }
    }

    void updateBrand(String? brand) {
      if (brand == null || brand == 'All') {
        ref.read(selectedBrandProvider.notifier).state = null;
      } else {
        ref.read(selectedBrandProvider.notifier).state = brand;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: allCategoriesWithAll.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final category = allCategoriesWithAll[index];
                  final isSelected = (selectedCategory == null && category == 'All') ||
                      selectedCategory == category;

                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    selectedColor: const Color(0xFFFF4548),
                    onSelected: (_) => updateCategory(category),
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  );
                },
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // Row with brand filter icon + brand label + list/grid toggle buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Brand filter icon and selected brand text
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () async {
                        final selected = await showDialog<String>(
                          context: context,
                          builder: (context) => SimpleDialog(
                            title: const Text('Select Brand'),
                            children: brandOptions.map((brand) {
                              return SimpleDialogOption(
                                onPressed: () => Navigator.pop(context, brand),
                                child: Text(brand),
                              );
                            }).toList(),
                          ),
                        );

                        if (selected != null) {
                          updateBrand(selected);
                        }
                      },
                    ),
                    Text(
                      selectedBrand ?? 'All Brands',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                // View toggle buttons (list/grid)
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.view_list,
                          color: viewType == ViewType.list ? Colors.black : Colors.grey),
                      onPressed: () {
                        ref.read(viewTypeProvider.notifier).state = ViewType.list;
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.grid_view,
                          color: viewType == ViewType.grid ? Colors.black : Colors.grey),
                      onPressed: () {
                        ref.read(viewTypeProvider.notifier).state = ViewType.grid;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Laptop list/grid
          Expanded(
            child: laptops.isEmpty
                ? const Center(child: Text('No laptops found'))
                : viewType == ViewType.list
                ? ListView.builder(
              itemCount: laptops.length,
              itemBuilder: (context, index) {
                final laptop = laptops[index];
                return ListTile(
                  leading: laptop.imageUrl.isNotEmpty
                      ? Image.asset(laptop.imageUrl,
                      width: 60, height: 60, fit: BoxFit.cover)
                      : const Icon(Icons.laptop, size: 60),
                  title: Text(laptop.name),
                  subtitle: Text(laptop.description),
                  trailing: Text('\$${laptop.price.toStringAsFixed(2)}'),
                );
              },
            )
                : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 3 / 4,
              ),
              itemCount: laptops.length,
              itemBuilder: (context, index) {
                final laptop = laptops[index];
                return Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: laptop.imageUrl.isNotEmpty
                            ? Image.asset(laptop.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity)
                            : const Icon(Icons.laptop, size: 80),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          laptop.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${laptop.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
