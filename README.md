# Image Preview Carousel

A Flutter package that provides a synchronized image carousel with a thumbnail gallery.

## Features

*   **Synchronized Views**: Swiping the main carousel updates the thumbnail selection, and tapping a thumbnail scrolls the carousel.
*   **Auto-scrolling Thumbnails**: The thumbnail list automatically scrolls to keep the selected image in view.
*   **Customizable**: Adjust heights, padding, and selection styling.
*   **Flexible Inputs**: Accepts any `List<ImageProvider>`, so you can use network images, assets, files, or memory images.

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

Follow these steps to implement the carousel in your app:

### Step 1: Import the package

In the file where you want to use the carousel, add the import statement:

```dart
import 'package:image_preview_carousel/image_preview_carousel.dart';
```

### Step 2: Prepare your images

Create a list of `ImageProvider` objects. These can be `NetworkImage`, `AssetImage`, `FileImage`, or `MemoryImage`.

```dart
final List<ImageProvider> myImages = [
  NetworkImage('https://via.placeholder.com/400x300'),
  NetworkImage('https://via.placeholder.com/400x300/ff0000'),
  AssetImage('assets/my_local_image.png'),
];
```

### Step 3: Add the Widget

Place the `ImagePreviewCarousel` widget in your build method.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Image Carousel Demo')),
    body: Center(
      child: ImagePreviewCarousel(
        images: myImages,
        carouselHeight: 300.0, // Optional: Height of the main image
        thumbnailHeight: 80.0, // Optional: Height of the thumbnails
      ),
    ),
  );
}
```

Ff combine with dialog :

```dart
InkWell(
    onTap: () async {
        showDialog(
            context: context,
            builder: (context) => Dialog(
                backgroundColor: whiteColor,
                child: ImagePreviewCarousel(
                    images: myImages,
                    carouselHeight:
                        300.0, // Optional: Height of the main image
                    thumbnailHeight:
                        80.0, // Optional: Height of the thumbnails
                ),
            ),
        );
    },
    child: Text(
        'See Images',
        style: LessworryTextStyle.txtMdRegular(
            context: context,
            color: Theme.of(context).primaryColor,
        ),
    ),
),
```

## Customization Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `images` | `List<ImageProvider>` | Required | List of images to display. |
| `carouselHeight` | `double` | `300.0` | Height of the main carousel area. |
| `thumbnailHeight` | `double` | `80.0` | Height of the horizontal thumbnail list. |
| `thumbnailPadding` | `EdgeInsetsGeometry` | `symmetric(horizontal: 4.0)` | Padding around each thumbnail item. |
| `initialIndex` | `int` | `0` | The index of the image to show first. |
| `selectedThumbnailBorderColor` | `Color` | `Colors.blue` | Color of the border for the active thumbnail. |
| `selectedThumbnailBorderWidth` | `double` | `2.0` | Width of the active thumbnail border. |
