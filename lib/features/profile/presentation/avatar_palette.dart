import 'package:flutter/material.dart';

abstract final class AvatarPalette {
  static const colors = [
    Color(0xFF4F46E5),
    Color(0xFF0EA5E9),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
    Color(0xFF64748B),
  ];

  static Color colorAt(int index) =>
      colors[index.clamp(0, colors.length - 1)];
}