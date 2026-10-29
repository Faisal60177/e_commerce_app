import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/products/application/product_list_provider.dart';
import 'package:e_commerce_app/features/products/application/product_query.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_grid_sliver.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/sort_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListScreen extends ConsumerStatefulWidget{

  const ProductListScreen({
    required this.title,
    this.category,
    this.initialSort = ProductSort.relevance,
    super.key,
  });


  final String title;
  final String? category;
  final ProductSort initialSort;

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {

  late ProductSort _sort = widget.initialSort;

  ProductQuery get _query =>
      ProductQuery(
          category: widget.category, sort: _sort
      );

  Future<void> _refresh() async {
    ref.invalidate(productListProvider(_query));
    try {
      await ref.read(productListProvider(_query).future);
    } on Failure {
      return;
    }
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification.depth == 0 && notification.metrics.extentAfter < 600) {
      ref.read(productListProvider(_query).notifier).loadMore();
    }
    return false;
  }

  @override
  Widget build (BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: context.openSearch, icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),

      body: RefreshIndicator(onRefresh: _refresh,
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SortChips(selected: _sort, onSelected: (sort) => setState (() => _sort = sort),

                    ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 8,),),
                  ProductGridSliver(query: _query),
                ],
              ))),

    );
  }
}