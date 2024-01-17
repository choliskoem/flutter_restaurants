import 'package:flutter/material.dart';
import 'package:flutter_dicoding_restaurant/gen/assets.gen.dart';
import 'package:flutter_dicoding_restaurant/presentation/favorite/pages/favorite_page.dart';
import 'package:flutter_dicoding_restaurant/presentation/listrest/pages/list_restaurant_page.dart';
import 'package:flutter_dicoding_restaurant/presentation/setting/pages/setting_page.dart';


import '../widgets/nav_item.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ListRestaurantPage(),
    const FavoritePage(),
   const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 30.0,
              blurStyle: BlurStyle.outer,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              iconPath: Assets.icons.restaurant,
              label: 'Home',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
              iconPath: Assets.icons.favorite,
              label: 'Favorite',
              isActive: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            NavItem(
              iconPath: Assets.icons.setting,
              label: 'Setting',
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}
