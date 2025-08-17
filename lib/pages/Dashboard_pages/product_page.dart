import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/product_components/brand_filter_and_view_toggle.dart';
import '../../components/product_components/category_tabs.dart';
import '../../components/product_components/laptop_grid_view.dart';
import '../../components/product_components/laptop_list_view.dart';
import '../../providers/category_provider.dart';
import '../../providers/selected_provider.dart';
import '../../providers/viewtype_provider.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final laptops = ref.watch(filteredLaptopsProvider);
    final viewType = ref.watch(viewTypeProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF4548).withOpacity(0.85),  // lighter variant by opacity
        title: Text(selectedCategory ?? 'All Laptops'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: CategoryTabs(),
        ),
      ),
      body: Column(
        children: [
          const BrandFilterAndViewToggleRow(),
          Expanded(
            child: laptops.isEmpty
                ? const Center(child: Text('No laptops found'))
                : (viewType == ViewType.list
                      ? LaptopListView(laptops: laptops)
                      : LaptopGridView(laptops: laptops)),
          ),
        ],
      ),
    );
  }
}
