import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({required this.products, super.key});

  final List<ProductSummary> products;

  @override
  State<BannerSlider> createState() => _BannerSliderState();

}

class _BannerSliderState extends State<BannerSlider> {
  final _controller = PageController(viewportFraction: 0.92);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) => _next() );
  }

  void _next() {
    final count = widget.products.length;
    if(!_controller.hasClients || count < 2) return;
    final next = ((_controller.page ?? 0).round() + 1) % count;
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
    final products = widget.products;
    if(products.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
              controller: _controller,
              itemCount: products.length,
              itemBuilder: (context, index) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _BannerCard(product: products[index]),

              ),
              )
    ),
  const SizedBox(height: 12,),
  SmoothPageIndicator(controller: _controller, count: products.length,
  effect: ExpandingDotsEffect(
  dotHeight: 8,
  dotWidth: 8,
  activeDotColor: context.colors.primary,
  dotColor: context.colors.outlineVariant,
  ),
  )

      ],
    );
}
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.product});

  final ProductSummary product;

@override
Widget build(BuildContext context) {
  final colors = context.colors;
  final radius = BorderRadius.circular(20);

  return Material(
    color: Colors.transparent,
    child: Ink(
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(colors: [colors.primary, colors.tertiary],
        begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child:  InkWell(
        borderRadius: radius,
        onTap: () => context.openProduct(product.id),
        child: Padding(padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('TOP RATED',
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.onPrimary.withValues(alpha: 0.8),
                  letterSpacing: 1.2,
                ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: colors.onPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  Formatters.price(product.discountedPrice),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w800,

                  ),
                ),
              ],
            ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 120,
              child: CachedNetworkImage(imageUrl: product.thumbnail,
              fit: BoxFit.contain,
                memCacheWidth: 400,
                errorWidget: (context, url, error) => Icon(
                  Icons.image_not_supported_outlined,
                  color: colors.onPrimary,
                ),
              ),
            )
          ],
        ),
        ),
      ),
    ),
  );
}

}

