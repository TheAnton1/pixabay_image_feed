import 'package:feed_test/features/details_screen/presentation/ui/Image_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../../common/card_entity_example.dart';

void main() {
  const testCard = CardEntityExamples.entityExample;

  group("detail screen test", () {
    testWidgets("Render is correct", (WidgetTester tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          const MaterialApp(
            home: ImageDetailScreenUI(imageDetail: testCard),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);

      expect(find.byIcon(Icons.close), findsOneWidget);

      expect(find.byType(Hero), findsOneWidget);
    });

    testWidgets("Pressing close button lead to close page", (WidgetTester tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          const MaterialApp(
            home: ImageDetailScreenUI(imageDetail: testCard),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.byType(ImageDetailScreenUI), findsNothing);
    });

    
  });
}
