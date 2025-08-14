import 'package:eproject_sem4/pages/Dashboard_pages/main_page.dart';
import 'package:eproject_sem4/pages/Dashboard_pages/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Define a StateProvider to hold the selected index of the nav bar
final selectedIndexProvider = StateProvider<int>((ref) => 0);

class GNavigation extends ConsumerWidget {
  const GNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. Watch the selected index state
    final selectedIndex = ref.watch(selectedIndexProvider);

    final List<Widget> pages = [
      MainPage(),
      Wishlist(),
      // You can add more pages later
      // SearchPage(),
      // SettingsPage(),
    ];

    return Scaffold(
      body: selectedIndex < pages.length ? pages[selectedIndex] : Container(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: GNav(
            gap: 4,
            activeColor: Colors.white,
            color: Colors.grey,
            tabBackgroundColor: const Color(0xFFFF4548),
            iconSize: 20,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: const Duration(milliseconds: 400),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Wishlist',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              // 3. Update the selected index state using Riverpod
              ref.read(selectedIndexProvider.notifier).state = index;
            },
          ),
        ),
      ),
    );
  }
}
