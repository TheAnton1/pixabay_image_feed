import 'package:feed_test/features/details_screen/presentation/ui/image_screen_ui.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';
import 'package:feed_test/features/main_screen/presentation/ui/image_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../common/card_entity_example.dart';

void main() {
  late CardEntity cardEntity;

  setUp(() {
    cardEntity = CardEntityExamples.entityExample;
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: Scaffold(
        body: ImageCard(cardEntity: cardEntity),
      ),
    );
  }

  group('ImageCard Widget Tests', () {
    testWidgets('should display correct image', (tester) async {
      // Mock network images
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byType(Image), findsOneWidget);
        final imageFinder = find.byType(Image);
        final image = tester.widget<Image>(imageFinder);
        expect(image.image, isInstanceOf<NetworkImage>());
        final networkImage = image.image as NetworkImage;
        expect(networkImage.url, cardEntity.image);
      });
    });

    testWidgets('should display correct likes and views', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text(cardEntity.likesAmount.toString()), findsOneWidget);
      expect(find.text(cardEntity.viewsAmount.toString()), findsOneWidget);
    });

    testWidgets('should navigate to ImageDetailScreenUI on tap',
        (tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.byType(ImageDetailScreenUI), findsOneWidget);
    });
  });
}
