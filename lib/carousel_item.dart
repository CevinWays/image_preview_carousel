import 'package:flutter/material.dart';

enum CarouselItemType { image, video }

class CarouselItem {
  final CarouselItemType type;
  final ImageProvider? image;
  final String? videoUrl;
  final ImageProvider? thumbnail;

  /// Create an item representing a static image.
  const CarouselItem.image({required this.image})
    : type = CarouselItemType.image,
      videoUrl = null,
      thumbnail = null;

  /// Create an item representing a video.
  /// [videoUrl] can be a network URL or a file path depending on how you implement the player.
  /// [thumbnail] is an image to show in the gallery or as a placeholder.
  const CarouselItem.video({required this.videoUrl, this.thumbnail})
    : type = CarouselItemType.video,
      image = null;
}
