/// Defines the data models for the carousel.
library carousel_item;

import 'package:flutter/material.dart';

/// The type of content to display in the carousel.
enum CarouselItemType {
  /// A static image.
  image,

  /// A video player.
  video,
}

/// Represents a single item in the [ImagePreviewCarousel].
///
/// Can be either an image or a video.
class CarouselItem {
  /// The type of this item (image or video).
  final CarouselItemType type;

  /// The image provider for the main content (if [type] is [CarouselItemType.image]).
  final ImageProvider? image;

  /// The URL or path to the video (if [type] is [CarouselItemType.video]).
  final String? videoUrl;

  /// The thumbnail image provider.
  ///
  /// For videos, this is displayed in the gallery.
  /// For images, if this is null, the [image] is used as the thumbnail.
  final ImageProvider? thumbnail;

  /// Create an item representing a static image.
  const CarouselItem.image({required this.image})
    : type = CarouselItemType.image,
      videoUrl = null,
      thumbnail = null;

  /// Create an item representing a video.
  ///
  /// [videoUrl] can be a network URL.
  /// [thumbnail] is an image to show in the gallery or as a placeholder.
  const CarouselItem.video({required this.videoUrl, this.thumbnail})
    : type = CarouselItemType.video,
      image = null;
}
