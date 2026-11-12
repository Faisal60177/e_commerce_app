import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';
import 'package:e_commerce_app/features/profile/presentation/avatar_palette.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget{
  const UserAvatar({
    required this.user,
    this.avatarIndex = 0,
    this.radius = 36,
    super.key,
  });

  final AppUser user;
  final int avatarIndex;
  final double radius;

@override
Widget build(BuildContext context) {
  final photo = user.photoUrl;

  if(photo != null && photo.isNotEmpty) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(photo),
    );
  }

  return CircleAvatar(
    radius: radius,
      backgroundColor: AvatarPalette.colorAt(avatarIndex),
    child: Text(
      user.initial,
      style: TextStyle(
        color: Colors.white,
        fontSize: radius * 0.8,
        fontWeight: .w700,
      ),
    ),
  );


}
}