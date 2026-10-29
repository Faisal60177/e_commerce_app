import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension AppNavigation on BuildContext {
  void openProduct(int id) =>
      pushNamed(RouteNames.productDetail, pathParameters: {'id': '$id'});

  void openCategory(String slug, [String? name]) => pushNamed(
    RouteNames.categoryProducts,
    pathParameters: {'slug': slug},
    extra: name,
  );

  void openProductList(String title, ProductSort sort) => pushNamed(
    RouteNames.productList,
    pathParameters: {'sort': sort.name},
    extra: title,
  );

  void openSearch() => pushNamed(RouteNames.search);
}