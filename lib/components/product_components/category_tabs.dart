import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/category_provider.dart';

class CategoryTabs extends ConsumerWidget {
  const CategoryTabs({super.key});

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

    void updateCategory(String category) {
      ref.read(selectedCategoryProvider.notifier).state = category == 'All'
          ? null
          : category;
    }

    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: allCategoriesWithAll.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = allCategoriesWithAll[index];
          final isSelected =
              (selectedCategory == null && category == 'All') ||
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
    );
  }
}
