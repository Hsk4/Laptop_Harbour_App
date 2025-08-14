import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/categories_model.dart';
import '../general_components/my_icon_component.dart';
import '../../pages/Dashboard_pages/product_page.dart';
import '../../providers/category_provider.dart'; // Adjust path as necessary

class CategoriesListComponent extends ConsumerWidget {
  const CategoriesListComponent({super.key});

  static const List<CategoryItem> categories = [
    CategoryItem(iconData: FontAwesomeIcons.gamepad, text: 'Gaming'),
    CategoryItem(iconData: FontAwesomeIcons.laptopCode, text: 'Office'),
    CategoryItem(iconData: FontAwesomeIcons.desktop, text: 'Workstation'),
    CategoryItem(iconData: FontAwesomeIcons.chrome, text: 'Chromebooks'),
    CategoryItem(iconData: FontAwesomeIcons.apple, text: 'MacBooks'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.text == selectedCategory;

          return GestureDetector(
            onTap: () {
              // Update selected category state
              ref.read(selectedCategoryProvider.notifier).state = category.text;

              // Navigate to ProductPage (no parameter needed, ProductPage watches provider)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductPage(),
                ),
              );
            },
            child: MyIconComponent(
              iconData: category.iconData,
              text: category.text,
              // Optionally pass isSelected to MyIconComponent to visually highlight it
              // e.g. selected: isSelected,
            ),
          );
        },
      ),
    );
  }
}
