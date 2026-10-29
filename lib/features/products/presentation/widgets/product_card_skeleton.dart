import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';

class ProductCardSkeleton extends StatelessWidget {

  const ProductCardSkeleton({super.key});


@override
Widget build(BuildContext context) {
  return const Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: ShimmerBox(radius: 0,)),
        Padding(padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShimmerBox(width: 100,height:  14,),
            SizedBox(height: 8,),
            ShimmerBox(width: 50, height: 12,),
            SizedBox(height: 8,),
            ShimmerBox(width: 80, height: 16,),
          ],
        ),
        )
      ],
    ),
  );


}
}