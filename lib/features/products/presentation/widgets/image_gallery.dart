import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageGallery extends StatefulWidget {

  const ImageGallery({required this.images, super.key});

  final List<String> images;

  @override
  State<ImageGallery> createState() => _ImageGalleryState();

}

class _ImageGalleryState extends State<ImageGallery> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    final colors = context.colors;

    return Column(
      children: [
        ColoredBox(color: colors.surfaceContainerHighest.withValues(alpha: 0.4),
        child: SizedBox(
          height: 320,
          width: double.infinity,
          child: images.isEmpty
          ? Center(
            child:  Icon(Icons.image_not_supported_outlined,size: 48,
            color: colors.outline,
            ),
          ) : PageView.builder(
            controller: _controller,
            itemCount: images.length,
            itemBuilder: (context, index) => Padding(padding: const EdgeInsets.all(16),
            child: CachedNetworkImage(imageUrl: images[index],fit: BoxFit.contain,
            placeholder: (context, url) =>
              const ShimmerBox(radius: 0,),
            errorWidget: (context, url, error) => Icon(Icons.image_not_supported_outlined, color: colors.outline,
            ),
            ),
            ),
          )
        ),
        ),
        if(images.length > 1)
          Padding(padding: const EdgeInsets.only(top: 12),
          child: SmoothPageIndicator(controller: _controller, count: images.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: colors.primary,
            dotColor: colors.outlineVariant
          ),),)
      ],
    );
  }


}