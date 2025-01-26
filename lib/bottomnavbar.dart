import 'package:flutter/material.dart';
import 'package:jeb_ui/profile.dart';

import 'all.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 4;
  final List<Widget> _screens = [
    const ProfileScreen(),
    const FavoritesPage(),
    const CartPage(),
    const HomeScreen(),


  ];

  @override
  Widget build(BuildContext context) {
    _currentIndex = _currentIndex.clamp(0, _screens.length - 1);
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.kContentColor,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 30),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 30),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),

        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.kprimaryColor,
        unselectedItemColor: AppColors.kunselectedItemColor,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
