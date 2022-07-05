import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tmdb/app.dart';

void main() {
  testWidgets('should build material app', (WidgetTester tester) async {
    //arrange
    await tester.pumpWidget(TmdbApp());
    MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
    var expectedTitle = "TMDB";

    //assert
    expect(materialApp.title, expectedTitle);
  });
}
