import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:flutter/material.dart';

class LineItemRow extends StatelessWidget{
  const LineItemRow({
    required this.title,
    required this.thumbnail,
    required this.unitPrice,
    required this.quantity,
    required this.lineTotal,
    this.onTap,
    super.key,
  });

  final String title;
  final String thumbnail;
  final double unitPrice;
  final int quantity;
  final double lineTotal;
  final VoidCallback? onTap;

@override
Widget build(BuildContext context) {
  final colors = context.colors;
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Padding(padding: const .symmetric(vertical: 8),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: .circular(10),
          child: SizedBox.square(
            dimension: 56,
            child: ColoredBox(color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
            child: CachedNetworkImage(imageUrl: thumbnail,
            fit: BoxFit.contain,
            memCacheWidth: 200,
            errorWidget: (context, url, error) => Icon(
              Icons.image_not_supported_outlined,
              color: colors.outline,
            ),),),
          ),
        ),
        const SizedBox(width: 12,),
        Expanded(child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleSmall,),
            const SizedBox(height: 2,),

            Text(
              '${Formatters.price(unitPrice)} * $quantity',
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        )),
        const SizedBox(width: 12,),
        Text(
          Formatters.price(lineTotal),
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: .w800,
          ),
        )
      ],
    ),),
  );



}



}