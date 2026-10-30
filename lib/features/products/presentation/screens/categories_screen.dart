import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:e_commerce_app/features/products/application/product_providers.dart';
import 'package:e_commerce_app/features/products/presentation/category_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  static const _delegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    mainAxisExtent: 76,
  );

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(categoriesProvider);
    try {
      await ref.read(categoriesProvider.future);
    } on Failure {
      return;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: categories.when(
        loading: () => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: _delegate,
          itemCount: 10,
          itemBuilder: (context, index) => const ShimmerBox(radius: 16),
        ),
        error: (error, stackTrace) => AppErrorView(
          message: failureMessage(error),
          onRetry: () => ref.invalidate(categoriesProvider),
        ),
        data: (items) => RefreshIndicator(
          onRefresh: () => _refresh(ref),
          child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: _delegate,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final category = items[index];
              return _CategoryTile(slug: category.slug, name: category.name);
            },
          ),
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.slug, required this.name});

  final String slug;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.openCategory(slug, name),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: context.colors.primaryContainer,
                child: Icon(
                  CategoryIcons.of(slug),
                  color: context.colors.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}