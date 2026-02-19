import 'package:flutter/material.dart';

import 'package:image_preview_carousel/carousel_item.dart';
import 'package:image_preview_carousel/video_player_widget.dart';

class ImagePreviewCarousel extends StatefulWidget {
  /// The list of items (images/videos) to display in the carousel and thumbnail gallery.
  final List<CarouselItem> items;

  /// The height of the main carousel area.
  final double carouselHeight;

  /// The height of the thumbnail gallery.
  final double thumbnailHeight;

  /// The padding around each thumbnail.
  final EdgeInsetsGeometry thumbnailPadding;

  /// The initial index to display.
  final int initialIndex;

  /// Color for the border of the selected thumbnail.
  final Color selectedThumbnailBorderColor;

  /// Width of the border for the selected thumbnail.
  final double selectedThumbnailBorderWidth;

  /// Icon to display on video thumbnails.
  final IconData videoIndicatorIcon;

  /// Color of the video indicator icon.
  final Color videoIndicatorColor;

  /// Color of the navigation arrows.
  final Color arrowColor;

  /// Size of the navigation arrows.
  final double arrowSize;

  const ImagePreviewCarousel({
    super.key,
    required this.items,
    this.carouselHeight = 300.0,
    this.thumbnailHeight = 80.0,
    this.thumbnailPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.initialIndex = 0,
    this.selectedThumbnailBorderColor = Colors.blue,
    this.selectedThumbnailBorderWidth = 2.0,
    this.videoIndicatorIcon = Icons.videocam,
    this.videoIndicatorColor = Colors.white,
    this.arrowColor = Colors.white,
    this.arrowSize = 30.0,
  });

  @override
  State<ImagePreviewCarousel> createState() => _ImagePreviewCarouselState();
}

class _ImagePreviewCarouselState extends State<ImagePreviewCarousel> {
  late PageController _pageController;
  late ScrollController _scrollController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _scrollToThumbnail(index);
  }

  void _onThumbnailTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    if (_currentIndex < widget.items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToThumbnail(int index) {
    if (_scrollController.hasClients) {
      final double itemExtent =
          widget.thumbnailHeight +
          (widget.thumbnailPadding.horizontal); // approximation
      final double targetOffset = itemExtent * index;

      _scrollController.animateTo(
        targetOffset > _scrollController.position.maxScrollExtent
            ? _scrollController.position.maxScrollExtent
            : targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenHeight = MediaQuery.of(context).size.height;
        final double maxSafeHeight = screenHeight - 112;

        double effectiveCarouselHeight = widget.carouselHeight;
        final double otherContentHeight = widget.thumbnailHeight + 12;

        if (effectiveCarouselHeight + otherContentHeight > maxSafeHeight) {
          effectiveCarouselHeight = maxSafeHeight - otherContentHeight;
          if (effectiveCarouselHeight < 100) effectiveCarouselHeight = 100;
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main Carousel
              SizedBox(
                height: effectiveCarouselHeight,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: widget.items.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        final item = widget.items[index];
                        if (item.type == CarouselItemType.video &&
                            item.videoUrl != null) {
                          return VideoPlayerWidget(videoUrl: item.videoUrl!);
                        }
                        return Image(image: item.image!, fit: BoxFit.contain);
                      },
                    ),

                    // Previous Arrow
                    if (_currentIndex > 0)
                      Positioned(
                        left: 8,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: widget.arrowColor,
                              size: widget.arrowSize,
                            ),
                            onPressed: _previousPage,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black26,
                              hoverColor: Colors.black45,
                            ),
                          ),
                        ),
                      ),

                    // Next Arrow
                    if (_currentIndex < widget.items.length - 1)
                      Positioned(
                        right: 8,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: widget.arrowColor,
                              size: widget.arrowSize,
                            ),
                            onPressed: _nextPage,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black26,
                              hoverColor: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Thumbnail Gallery
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: widget.thumbnailHeight,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.items.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    final bool isSelected = index == _currentIndex;

                    ImageProvider? thumbImage;
                    if (item.type == CarouselItemType.image) {
                      thumbImage = item.image;
                    } else {
                      thumbImage = item.thumbnail;
                    }

                    return GestureDetector(
                      onTap: () => _onThumbnailTap(index),
                      child: Padding(
                        padding: widget.thumbnailPadding,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                isSelected
                                    ? Border.all(
                                      color:
                                          widget.selectedThumbnailBorderColor,
                                      width:
                                          widget.selectedThumbnailBorderWidth,
                                    )
                                    : Border.all(color: Color(0xffEEF0F0)),
                          ),
                          child: Opacity(
                            opacity: isSelected ? 1.0 : 0.6,
                            child: AspectRatio(
                              aspectRatio: 1.0, // Square thumbnails
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (thumbImage != null)
                                    Image(image: thumbImage, fit: BoxFit.cover)
                                  else
                                    Visibility(
                                      visible:
                                          item.type == CarouselItemType.image,
                                      child: Container(
                                        color: Colors.black12,
                                        child: const Icon(Icons.broken_image),
                                      ),
                                    ), // Fallback for missing thumbnail

                                  if (item.type == CarouselItemType.video)
                                    Center(
                                      child: Icon(
                                        widget.videoIndicatorIcon,
                                        color: widget.videoIndicatorColor,
                                        size: 24,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
