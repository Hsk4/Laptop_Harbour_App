import 'package:eproject_sem4/components/appbar_component.dart';
import 'package:eproject_sem4/components/carousel_component.dart';
import 'package:eproject_sem4/components/categories_List_component.dart';
import 'package:eproject_sem4/components/seeall_component.dart';
import 'package:eproject_sem4/pages/Dashboard_pages/product_page.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // main column for the main page
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // app bar container
                  AppbarComponent(),

                  // special for you and see all buttons
                  SeeAllComponent(
                    text: 'SpecialForYou',
                    textButton: 'See All',
                    onTap: () {},
                  ),

                  //special for you section carousel
                  ImageCarousel(
                    imageUrls: [
                      'assets/images/special1.jpg',
                      'assets/images/special2.jpg',
                      'assets/images/special3.jpg',
                    ],
                  ),

                  // categories text section
                  SeeAllComponent(
                    text: 'Categories',
                    textButton: 'See All',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductPage(),
                        ),
                      );
                    },
                  ),

                  // categories section
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 400, // adjust width as desired
                        child: CategoriesListComponent(),
                      ),
                    ),
                  ),

                  // flash sale section
                ],
              ),
            ),
          ),


    );
  }
}
