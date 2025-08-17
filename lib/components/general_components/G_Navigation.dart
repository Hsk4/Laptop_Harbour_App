import 'package:eproject_sem4/pages/Dashboard_pages/main_page.dart';
import 'package:eproject_sem4/pages/Dashboard_pages/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../pages/Dashboard_pages/cart_page.dart';
import '../../pages/Dashboard_pages/profile_page.dart';
import '../../pages/Dashboard_pages/support_page.dart';

class GNavigation extends StatefulWidget {
  const GNavigation({super.key});

  @override
  State<GNavigation> createState() => _GNavigationState();
}

class _GNavigationState extends State<GNavigation> {
  int _selectedIndex = 0;
// all the pages are commented out for now

  final List<Widget> _pages = [
    MainPage(),
    WishlistPage(),
    CartPage(),
    SupportPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {


    return   Scaffold(

      body:_selectedIndex < _pages.length ? _pages[_selectedIndex]
          : Container(),
      bottomNavigationBar: Container(
        color: Colors.white,

        child:
        Padding(padding: EdgeInsets.all(20.w),
          child: GNav(
            gap: 4,
            activeColor: Colors.white,
            color: Colors.grey,
            tabBackgroundColor:Color(0xFFFF4548),
            iconSize: 20,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 400),
            tabs:[
              GButton(
                icon: Icons.home,

              ),
              GButton(
                icon: Icons.favorite,

              ),

              GButton(
                icon: Icons.shopping_cart,

              ),
              GButton(
                icon: Icons.support_agent_rounded,

              ),
              GButton(
                icon: Icons.person,

              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },

          ),

        ),
      ),
    );
  }
}
