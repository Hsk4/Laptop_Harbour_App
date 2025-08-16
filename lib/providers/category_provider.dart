import 'package:eproject_sem4/providers/selected_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Laptop_model.dart';
import '../data/laptop_data.dart';

// Nullable selected category; null means "all laptops"
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// Returns laptops filtered by selectedCategory, or all if none selected
final filteredLaptopsProvider = Provider<List<Laptop>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final selectedBrand = ref.watch(selectedBrandProvider);

  Iterable<Laptop> filtered = laptops;

  if (selectedCategory != null && selectedCategory != 'All') {
    filtered = filtered.where((l) => l.category == selectedCategory);
  }

  if (selectedBrand != null && selectedBrand != 'All') {
    filtered = filtered.where((l) => l.brand == selectedBrand);
  }

  final list = filtered.toList();
  if (selectedCategory == null || selectedCategory == 'All') {
    list.shuffle();
  }

  return list;
});
