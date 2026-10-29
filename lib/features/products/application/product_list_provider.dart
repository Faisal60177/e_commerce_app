import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/models/paginated.dart';
import 'package:e_commerce_app/features/products/application/product_list_state.dart';
import 'package:e_commerce_app/features/products/application/product_query.dart';
import 'package:e_commerce_app/features/products/application/product_repository_provider.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_list_provider.g.dart';


@riverpod
class ProductList   extends _$ProductList {
  @override
  Future<ProductListState> build(ProductQuery query) async {
    final page = await _fetch(skip: 0);
    return ProductListState(items: page.items, total: page.total);
  }

  Future<Paginated<ProductSummary>> _fetch({required int skip}) {
    final repository = ref.read(productRepositoryProvider);
    final search = query.search?.trim();
    final category = query.category;

    if(search != null && search.isNotEmpty) {
      return repository.searchProducts(search, skip: skip, sort: query.sort);

    }
    if(category != null){
      return repository.getProductsByCategory(
        category, skip:skip,
        sort: query.sort,
      );
    }
    return repository.getProducts(skip: skip, sort: query.sort);
  }

  Future<void> loadMore() async {
    final current = state.value;
    if(current == null ||current.isLoadingMore || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    try {
      final page = await _fetch(skip: current.items.length);
      if(!ref.mounted) return;
      state = AsyncData(current.copyWith(
        items: [...current.items, ...page.items],
        total: page.total,
        isLoadingMore: false,
      ));
    } on Failure catch (failure) {
      if(!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false,loadMoreError: failure));
    }



  }


}