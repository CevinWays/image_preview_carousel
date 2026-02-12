import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_preview_carousel/carousel_item.dart';
import 'package:image_preview_carousel/image_preview_carousel.dart';

void main() {
  final Uint8List kTransparentImage = Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ]);

  testWidgets('Dialog with Column and Carousel renders without error', (
    WidgetTester tester,
  ) async {
    final items = [CarouselItem.image(image: MemoryImage(kTransparentImage))];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => Dialog(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 50,
                                color: Colors.blue,
                              ), // Simulate header
                              ImagePreviewCarousel(
                                items: items,
                                carouselHeight: 300,
                                thumbnailHeight: 80,
                              ),
                            ],
                          ),
                        ),
                  );
                },
                child: const Text('Open Dialog'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open Dialog'));
    await tester.pumpAndSettle();

    expect(find.byType(Dialog), findsOneWidget);
    expect(find.byType(ImagePreviewCarousel), findsOneWidget);
  });
}
