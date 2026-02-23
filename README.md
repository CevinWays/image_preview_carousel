# Image Preview Carousel

A Flutter package that provides a synchronized image and video carousel with a thumbnail gallery.

## Features

*   **Mixed Media Support**: Display both images and videos in the same carousel.
*   **Synchronized Views**: Swiping the main carousel updates the thumbnail selection, and tapping a thumbnail scrolls the carousel.
*   **Navigation Arrows**: Built-in Previous/Next arrows for easy navigation.
*   **Auto-scrolling Thumbnails**: The thumbnail list automatically scrolls to keep the selected item in view.
*   **Customizable**: Adjust heights, padding, selection styling, arrow colors, and more.
*   **Video Playback**: Native video playback support with play/pause controls.

## Installation

Add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  image_preview_carousel:
    path: ./ # Or the git/pub url if published
```

Then run:
```bash
flutter pub get
```

## Usage

> **BREAKING CHANGE in v0.0.2**: The `images` parameter (`List<ImageProvider>`) has been replaced by `items` - `(List<CarouselItem>)` to support videos.

### Step 1: Import the package

```dart
import 'package:image_preview_carousel/image_preview_carousel.dart';
import 'package:image_preview_carousel/carousel_item.dart';
```

### Step 2: Prepare your items

Create a list of `CarouselItem` objects. You can mix images and videos.

```dart
final List<CarouselItem> myItems = [
  // Image from Asset
  CarouselItem.image(
    image: AssetImage('assets/images/image1.png'),
  ),
  
  // Image from Network
  CarouselItem.image(
    image: NetworkImage('https://example.com/photo.jpg'),
  ),

  // Video from Network
  CarouselItem.video(
    videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    // Optional: Provide a thumbnail for the video in the gallery
    thumbnail: NetworkImage('https://example.com/video_thumb.jpg'), 
  ),
];
```

### Step 3: Add the Widget

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Media Carousel Demo')),
    body: Center(
      child: ImagePreviewCarousel(
        items: myItems,
        carouselHeight: 300.0,
        thumbnailHeight: 80.0,
        maxHeight: 500.0, // Optional: Explicitly limit the total height of the widget, If null, it calculates based on constraints.
        arrowColor: Colors.white, // Customize arrow color
        videoIndicatorColor: Colors.red, // Customize video icon color on thumbnails
      ),
    ),
  );
}
```

## Customization Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `items` | `List<CarouselItem>` | Required | List of `CarouselItem.image` or `CarouselItem.video` to display. |
| `carouselHeight` | `double` | `300.0` | Height of the main carousel area. |
| `thumbnailHeight` | `double` | `80.0` | Height of the horizontal thumbnail list. |
| `thumbnailPadding` | `EdgeInsetsGeometry` | `symmetric(horizontal: 4.0)` | Padding around each thumbnail item. |
| `initialIndex` | `int` | `0` | The index of the item to show first. |
| `selectedThumbnailBorderColor` | `Color` | `Colors.blue` | Color of the border for the active thumbnail. |
| `selectedThumbnailBorderWidth` | `double` | `2.0` | Width of the active thumbnail border. |
| `videoIndicatorIcon` | `IconData` | `Icons.videocam` | Icon to show on video thumbnails. |
| `videoIndicatorColor` | `Color` | `Colors.white` | Color of the video indicator icon. |
| `arrowColor` | `Color` | `Colors.white` | Color of the navigation arrows. |
| `arrowSize` | `double` | `30.0` | Size of the navigation arrows. |
| `maxHeight` | `double?` | `null` | Maximum allowed total height. If null, it's calculated automatically based on available space to prevent overflow. |

### `CarouselItem` Details

| Property | Type | Default | Description |
|---|---|---|---|
| `type` | `CarouselItemType` | `Required` | Either `CarouselItemType.image` or `CarouselItemType.video`. |
| `image` | `ImageProvider?` | `null` | The image to display (for image type). |
| `videoUrl` | `String?` | `null` | The URL of the video to play (for video type). |
| `thumbnail` | `ImageProvider?` | `null` | Optional thumbnail for video gallery. |

