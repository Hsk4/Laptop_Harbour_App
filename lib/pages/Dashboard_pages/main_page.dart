import 'package:eproject_sem4/components/mainpage_components/appbar_component.dart';
import 'package:eproject_sem4/components/mainpage_components/carousel_component.dart';
import 'package:eproject_sem4/components/mainpage_components/categories_List_component.dart';
import 'package:eproject_sem4/components/general_components/seeall_component.dart';
import 'package:eproject_sem4/pages/Dashboard_pages/product_page.dart';
import 'package:flutter/material.dart';

import '../../providers/category_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {  // note: ConsumerState instead of State
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppbarComponent(),

              SeeAllComponent(
                text: 'SpecialForYou',
                textButton: 'See All',
                onTap: () {},
              ),

              ImageCarousel(
                imageUrls: [
                  'assets/images/special1.jpg',
                  'assets/images/special2.jpg',
                  'assets/images/special3.jpg',
                ],
              ),

              SeeAllComponent(
                text: 'Categories',
                textButton: 'See All',
                onTap: () {
                  // Reset the selectedCategoryProvider before navigating
                  ref.read(selectedCategoryProvider.notifier).state = null;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductPage(),
                    ),
                  );
                },
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 400,
                    child: CategoriesListComponent(),
                  ),
                ),
              ),

              // Flash sale section (if any)
            ],
          ),
        ),
      ),
    );
  }
}