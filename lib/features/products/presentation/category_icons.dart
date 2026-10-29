import 'package:flutter/material.dart';

abstract final class CategoryIcons {
  static IconData of(String slug) => _icons[slug] ?? Icons.category_rounded;

  static const _icons = <String, IconData>{
    'beauty': Icons.face_retouching_natural,
    'fragrances': Icons.spa_rounded,
    'furniture': Icons.chair_rounded,
    'groceries': Icons.local_grocery_store_rounded,
    'home-decoration': Icons.home_work_rounded,
    'kitchen-accessories': Icons.kitchen_rounded,
    'laptops': Icons.laptop_mac_rounded,
    'mens-shirts': Icons.checkroom_rounded,
    'mens-shoes': Icons.directions_walk_rounded,
    'mens-watches': Icons.watch_rounded,
    'mobile-accessories': Icons.headphones_rounded,
    'motorcycle': Icons.two_wheeler_rounded,
    'skin-care': Icons.water_drop_rounded,
    'smartphones': Icons.smartphone_rounded,
    'sports-accessories': Icons.sports_basketball_rounded,
    'sunglasses': Icons.visibility_rounded,
    'tablets': Icons.tablet_mac_rounded,
    'tops': Icons.dry_cleaning_rounded,
    'vehicle': Icons.directions_car_rounded,
    'womens-bags': Icons.shopping_bag_rounded,
    'womens-dresses': Icons.woman_rounded,
    'womens-jewellery': Icons.diamond_rounded,
    'womens-shoes': Icons.directions_walk_rounded,
    'womens-watches': Icons.watch_later_rounded,
  };
}