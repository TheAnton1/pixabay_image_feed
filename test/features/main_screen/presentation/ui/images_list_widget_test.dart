import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_cubit.dart';
import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_state.dart';
import 'package:feed_test/features/main_screen/presentation/ui/image_card_widget.dart';
import 'package:feed_test/features/main_screen/presentation/ui/images_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../common/card_entity_example.dart';

class MockFeedScreenCubit extends Mock implements FeedScreenCubit {}

void main() {
  late MockFeedScreenCubit mockCubit;
  late TextEditingController textEditingController;

  setUp(() {
    mockCubit = MockFeedScreenCubit();
    textEditingController = TextEditingController();
  });

  Widget createTestWidget() {
    return BlocProvider<FeedScreenCubit>(
      create: (_) => mockCubit,
      child: ImagesListWidget(
        textEditingController: textEditingController,
      ),
    );
  }

  group("Image grid tests", () {
    testWidgets(
        "progress indicator displayed when [FeedLoading] and first fetch",
        (widgetTester) async {
      when(() => mockCubit.state)
          .thenReturn(const FeedLoading(isFirstFetch: true, imageList: []));

      await widgetTester.pumpWidget(createTestWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets("grid displayed when [FeedLoaded]", (widgetTester) async {
      when(() => mockCubit.state).thenReturn(
          const FeedLoaded(images: [CardEntityExamples.entityExample]));

      await widgetTester.pumpWidget(createTestWidget());

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets("number of cards equal to length of list when [FeedLoaded]",
        (widgetTester) async {
      const images = [CardEntityExamples.entityExample];
      when(() => mockCubit.state).thenReturn(const FeedLoaded(images: images));

      await widgetTester.pumpWidget(createTestWidget());

      expect(find.byType(ImageCard), findsNWidgets(images.length));
    });

    testWidgets("error message displayed when [FeedError]",
        (widgetTester) async {
      const errorMessage = "Something went wrong";
      when(() => mockCubit.state)
          .thenReturn(const FeedError(message: errorMessage));

      await widgetTester.pumpWidget(createTestWidget());

      expect(find.text(errorMessage), findsOneWidget);
    });
  });
}
