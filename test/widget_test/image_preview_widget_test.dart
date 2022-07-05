import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb/data/models/images_model.dart';
import 'package:tmdb/presentation/screens/image_preview_screen.dart';

void main() {
  late final ImageModel imageModel;

  setUpAll(() {
    HttpOverrides.global = null;
    imageModel = ImageModel(
        aspectRatio: 0.667,
        height: 2785,
        iso6391: null,
        filePath: "/tmU9jtSs6c4ySC5eiad3aXXADan.jpg",
        voteAverage: 5.206,
        voteCount: 9,
        width: 1857);
  });
  testWidgets('find download button and image in image preview screen',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
          MaterialApp(home: ImagePreviewScreen(imageModel: imageModel)));

      expect(find.byType(IconButton), findsOneWidget);

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}
