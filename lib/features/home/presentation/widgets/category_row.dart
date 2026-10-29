import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/widgets/inline_error.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:e_commerce_app/features/products/application/product_providers.dart';
import 'package:e_commerce_app/features/products/presentation/category_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryRow extends ConsumerWidget {
const CategoryRow({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
  final categories = ref.watch(categoriesProvider);

  return SizedBox(
    height: 104,
    child: categories.when(
      loading: () => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        separatorBuilder: (context, index) => const SizedBox(width: 16,),
          itemBuilder: (context, index) => const Column(
            children: [
              ShimmerBox(width: 56, height: 56, radius: 28,),
              SizedBox(height: 8,),
              ShimmerBox(width: 56, height: 10,),
            ],
          ),
      ),
      error: (error, stackTrace) => InlineError(message: failureMessage(error), onRetry: () => ref.invalidate(categoriesProvider),
      ),
      data: (items) => ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16,),
        itemBuilder: (context , index) {
          final category = items[index];
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => context.openCategory(category.slug, category.name),
            child: SizedBox(
              width: 76,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: context.colors.primaryContainer,
                    child: Icon(CategoryIcons.of(category.slug),
                    color: context.colors.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text(category.name,
                  maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelMedium,
                  )
                ],
              ),
            ),
          );
        },
      )
    ),
  );

  }

}