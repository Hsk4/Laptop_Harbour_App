import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/categories_model.dart';
import 'general_components/my_icon_component.dart';


class CategoriesListComponent extends StatelessWidget {
  const CategoriesListComponent({super.key});

  static const List<CategoryItem> categories = [
    CategoryItem(iconData: FontAwesomeIcons.gamepad, text: 'Gaming'),
    CategoryItem(iconData: FontAwesomeIcons.laptopCode, text: 'Office'),
    CategoryItem(iconData: FontAwesomeIcons.desktop, text: 'Workstations'),
    CategoryItem(iconData: FontAwesomeIcons.chrome, text: 'Chromebooks'),
    CategoryItem(iconData: FontAwesomeIcons.apple, text: 'MacBooks'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Height to fit icon + text comfortably
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          final category = categories[index];
          return MyIconComponent(
            iconData: category.iconData,
            text: category.text,
            onTap: () {
              // Handle taps here
              debugPrint('Tapped category: ${category.text}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped ${category.text}')),
              );
            },
          );
        },
      ),
    );

  }
}
