import 'package:flutter/material.dart';
import 'package:image_preview_carousel/carousel_item.dart';
import 'package:image_preview_carousel/image_preview_carousel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Preview Carousel Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Image Preview Carousel Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<CarouselItem> _items = [
    CarouselItem.image(
      image: const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      ),
    ),
    CarouselItem.image(
      image: const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
      ),
    ),
    CarouselItem.video(
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      thumbnail: const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', // Placeholder thumbnail
      ),
    ),
    CarouselItem.image(
      image: const NetworkImage(
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/falcon.jpg',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Image Preview Carousel Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ImagePreviewCarousel(
              items: _items,
              carouselHeight: 300,
              thumbnailHeight: 80,
              thumbnailPadding: const EdgeInsets.all(4),
              initialIndex: 0,
              selectedThumbnailBorderColor: Colors.deepPurple,
              selectedThumbnailBorderWidth: 3,
              arrowColor: Colors.white,
              arrowSize: 32,
              videoIndicatorColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
