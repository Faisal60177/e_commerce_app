import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget{

  const ShimmerBox({this.width, this.height, this.radius = 12, super.key});

  final double? width;
  final double? height;
  final double? radius;

@override
Widget build(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  
  return Shimmer.fromColors(
    
    baseColor:  isDark? const Color(0xFF2A2A2E) : const Color(0xFFE5E7EB),
    highlightColor: isDark? const Color(0xFF3A3A40) : const Color(0xFFF3F4F6),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius!),
      ),
    ),

    
    
  );
  
}


}