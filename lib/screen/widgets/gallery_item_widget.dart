import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem(this.imageUrl, {Key? key}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: 150,
      width: 150,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          //shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider),
        ),
      ),
      ///Can replace with simmer
      placeholder: (context, url) => SizedBox(
          width: 68.0,
          height: 68.0,
          child: Image.asset("assets/images/ic_place_holder.png",)),
      errorWidget: (context, url, error) => SizedBox(
          width: 68.0,
          height: 68.0,
          child: Image.asset("assets/images/ic_place_holder.png")),
    );

  }
}