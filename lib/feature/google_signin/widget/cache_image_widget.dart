import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/helper/global_widgets.dart';

class CacheImageWidget extends StatelessWidget {
  const CacheImageWidget({
    super.key,
    this.height,
    this.width,
    this.imageUrl,
  });

  final double? height;
  final double? width;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) => Container(
        height: width,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const ImageErrorWidget(),
    );
  }
}
