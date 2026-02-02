import 'package:flutter/material.dart';

class ImagePreviewCarousel extends StatefulWidget {
  /// The list of images to display in the carousel and thumbnail gallery.
  final List<ImageProvider> images;

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

  const ImagePreviewCarousel({
    super.key,
    required this.images,
    this.carouselHeight = 300.0,
    this.thumbnailHeight = 80.0,
    this.thumbnailPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.initialIndex = 0,
    this.selectedThumbnailBorderColor = Colors.blue,
    this.selectedThumbnailBorderWidth = 2.0,
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

  void _onUnicornPageChanged(int index) {
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

  void _scrollToThumbnail(int index) {
    // Simple logic to scroll thumbnail into view if needed
    // precise scrolling calculation can be added for better UX
    if (_scrollController.hasClients) {
      final double itemExtent =
          widget.thumbnailHeight +
          (widget.thumbnailPadding.horizontal); // approximation
      final double targetOffset = itemExtent * index;

      // We might want to center it, but for now simple ensuring it's visible is good
      // This is a basic implementation, creating a more centered scroll approach requires knowing effective item widths
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main Carousel
        SizedBox(
          height: widget.carouselHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: _onUnicornPageChanged,
            itemBuilder: (context, index) {
              return Image(image: widget.images[index], fit: BoxFit.contain);
            },
          ),
        ),

        const SizedBox(height: 12),

        // Thumbnail Gallery
        SizedBox(
          height: widget.thumbnailHeight,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final bool isSelected = index == _currentIndex;
              return GestureDetector(
                onTap: () => _onThumbnailTap(index),
                child: Padding(
                  padding: widget.thumbnailPadding,
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          isSelected
                              ? Border.all(
                                color: widget.selectedThumbnailBorderColor,
                                width: widget.selectedThumbnailBorderWidth,
                              )
                              : null,
                    ),
                    child: Opacity(
                      opacity: isSelected ? 1.0 : 0.6,
                      child: AspectRatio(
                        aspectRatio: 1.0, // Square thumbnails
                        child: Image(
                          image: widget.images[index],
                          fit: BoxFit.cover,
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
    );
  }
}
