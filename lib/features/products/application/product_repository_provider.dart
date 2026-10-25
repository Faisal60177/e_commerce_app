import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/features/products/data/product_repository_impl.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref){
  return ProductRepositoryImpl(ref.watch(dioProvider));
}

