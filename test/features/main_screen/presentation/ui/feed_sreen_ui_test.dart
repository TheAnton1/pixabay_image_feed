import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_cubit.dart';
import 'package:feed_test/features/main_screen/presentation/ui/feed_screen_ui.dart';
import 'package:feed_test/features/main_screen/presentation/ui/images_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFeedScreenCubit extends Mock implements FeedScreenCubit {}

void main() {
  late MockFeedScreenCubit mockCubit;
  late TextEditingController textEditingController;

  setUp(() {
    mockCubit = MockFeedScreenCubit();
    textEditingController = TextEditingController();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<FeedScreenCubit>(
        create: (_) => mockCubit,
        child: const FeedScreenUI(),
      ),
    );
  }

  group("FeedScreenUI Tests", () {
    testWidgets("should display AppBar and TextField", (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets("should call clearFeed and loadSearchImages on text input", (tester) async {
      when(() => mockCubit.clearFeed()).thenAnswer((_) async {});
      when(() => mockCubit.loadSearchImages(any())).thenAnswer((_) async {});

      await tester.pumpWidget(createTestWidget());

      final textField = find.byType(TextField);
      await tester.enterText(textField, "search query");
      await tester.pump(const Duration(milliseconds: 1000)); // Wait for debounce

      verify(() => mockCubit.clearFeed()).called(1);
      verify(() => mockCubit.loadSearchImages("search query")).called(1);
    });

    testWidgets("should display ImagesListWidget", (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ImagesListWidget), findsOneWidget);
    });

    testWidgets("should debounce text input", (tester) async {
      when(() => mockCubit.clearFeed()).thenAnswer((_) async {});
      when(() => mockCubit.loadSearchImages(any())).thenAnswer((_) async {});

      await tester.pumpWidget(createTestWidget());

      final textField = find.byType(TextField);
      await tester.enterText(textField, "a");
      await tester.pump(const Duration(milliseconds: 400)); // Wait less than debounce duration
      await tester.enterText(textField, "ab");
      await tester.pump(const Duration(milliseconds: 1000)); // Wait for debounce

      verify(() => mockCubit.clearFeed()).called(2); // Once for each text input
      verify(() => mockCubit.loadSearchImages("a")).called(0); // Should not be called
      verify(() => mockCubit.loadSearchImages("ab")).called(1); // Should be called once
    });
  });
}
