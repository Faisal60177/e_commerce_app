import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell  extends StatelessWidget{
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

@override
Widget build(BuildContext context) {
return Scaffold(
  body: navigationShell,
  bottomNavigationBar: NavigationBar(
    selectedIndex: navigationShell.currentIndex,
    onDestinationSelected: (index) => navigationShell.goBranch(
      index, initialLocation: index == navigationShell.currentIndex,
    ),

    destinations: const[

      NavigationDestination(icon: Icon(Icons.home_outlined,), selectedIcon: Icon(Icons.home_rounded),label: 'Home'
      ),

      NavigationDestination(
        icon: Icon(Icons.grid_view_outlined),
        selectedIcon: Icon(Icons.grid_view_rounded),
        label: 'Categories',
      ),
      NavigationDestination(
        icon: Icon(Icons.shopping_cart_outlined),
        selectedIcon: Icon(Icons.shopping_cart_rounded),
        label: 'Cart',
      ),
      NavigationDestination(
        icon: Icon(Icons.favorite_border_rounded),
        selectedIcon: Icon(Icons.favorite_rounded),
        label: 'Wishlist',
      ),
      NavigationDestination(
        icon: Icon(Icons.person_outline_rounded),
        selectedIcon: Icon(Icons.person_rounded),
        label: 'Account',
      ),
    ],

  ),

);
}
}