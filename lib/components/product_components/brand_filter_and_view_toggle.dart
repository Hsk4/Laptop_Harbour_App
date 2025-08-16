import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/category_provider.dart';
import '../../providers/selected_provider.dart';
import '../../providers/viewtype_provider.dart';

class BrandFilterAndViewToggleRow extends ConsumerWidget {
  const BrandFilterAndViewToggleRow({super.key});

  static const brandOptions = [
    'All',
    'Dell',
    'HP',
    'Apple',
    'Acer',
    // add more as needed
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBrand = ref.watch(selectedBrandProvider);
    final viewType = ref.watch(viewTypeProvider);

    void updateBrand(String? brand) {
      ref.read(selectedBrandProvider.notifier).state =
          (brand == null || brand == 'All') ? null : brand;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Brand filter icon & label with dialog
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

                  if (selected != null) updateBrand(selected);
                },
              ),
              Text(
                selectedBrand ?? 'All Brands',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          // View toggle buttons
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.view_list,
                  color: viewType == ViewType.list ? Colors.black : Colors.grey,
                ),
                onPressed: () =>
                    ref.read(viewTypeProvider.notifier).state = ViewType.list,
              ),
              IconButton(
                icon: Icon(
                  Icons.grid_view,
                  color: viewType == ViewType.grid ? Colors.black : Colors.grey,
                ),
                onPressed: () =>
                    ref.read(viewTypeProvider.notifier).state = ViewType.grid,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
