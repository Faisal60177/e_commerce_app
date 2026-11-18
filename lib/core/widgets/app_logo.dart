import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({this.size = 96, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icon/app_icon_foreground.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      semanticLabel: 'ShopEase logo',
    );
  }
}