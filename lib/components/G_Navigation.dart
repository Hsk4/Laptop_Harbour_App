import 'package:eproject_sem4/pages/Dashboard_pages/main_page.dart';
import 'package:eproject_sem4/pages/Dashboard_pages/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
    Wishlist(),
    // SearchPage(),
    // SettingsPage(),
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
                text: 'Home' ,
              ),
              GButton(
                icon: Icons.favorite,
                text: 'wishlist' ,
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
