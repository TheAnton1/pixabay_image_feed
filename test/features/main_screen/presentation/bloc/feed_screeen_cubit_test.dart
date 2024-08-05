import 'package:dartz/dartz.dart';
import 'package:feed_test/core/network/failure.dart';
import 'package:feed_test/features/main_screen/domain/usecases/get_all_images.dart';
import 'package:feed_test/features/main_screen/domain/usecases/search_images.dart';
import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_cubit.dart';
import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../../common/card_entity_example.dart';

class MockGetAllImages extends Mock implements GetAllImages {}

class MockSearchImages extends Mock implements SearchImages {}

void main() {
  late FeedScreenCubit cubit;
  late MockGetAllImages mockGetAllImages;
  late MockSearchImages mockSearchImages;

  setUp(() {
    mockSearchImages = MockSearchImages();
    mockGetAllImages = MockGetAllImages();
    cubit = FeedScreenCubit(
        getAllImages: mockGetAllImages, searchImages: mockSearchImages);
  });

  test("initial state is empty", () {
    expect(cubit.state, isA<FeedEmpty>());
  });

  blocTest<FeedScreenCubit, FeedScreenState>(
    'emits FeedEmpty when clearFeed is called',
    build: () => cubit,
    seed: () => const FeedLoaded(images: [CardEntityExamples.entityExample]),
    act: (cubit) => cubit.clearFeed(),
    expect: () => [FeedEmpty()],
  );

  group("Get all images", () {
    blocTest<FeedScreenCubit, FeedScreenState>(
      "emits [FeedLoading, FeedLoaded] when load images",
      build: () {
        when(() => mockGetAllImages.call(any())).thenAnswer(
            (_) async => const Right([CardEntityExamples.entityExample]));
        return cubit;
      },
      act: (cubit) => cubit.loadImages(),
      expect: () => [isA<FeedLoading>(), isA<FeedLoaded>()],
    );
    blocTest<FeedScreenCubit, FeedScreenState>(
      "emits [FeedLoading, FeedError] when failed",
      build: () {
        when(() => mockGetAllImages.call(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return cubit;
      },
      act: (cubit) => cubit.loadImages(),
      expect: () => [isA<FeedLoading>(), isA<FeedError>()],
    );
    group("Search images", () {
      const String query = "kittens";
      blocTest<FeedScreenCubit, FeedScreenState>(
        "emits [FeedLoading, FeedLoaded] when load images",
        build: () {
          when(() => mockSearchImages.call(any(), any())).thenAnswer(
              (_) async => const Right([CardEntityExamples.entityExample]));
          return cubit;
        },
        act: (cubit) => cubit.loadSearchImages(query),
        expect: () => [isA<FeedLoading>(), isA<FeedLoaded>()],
      );

      blocTest<FeedScreenCubit, FeedScreenState>(
        "emits [FeedLoading, FeedError] when failed",
        build: () {
          when(() => mockSearchImages.call(any(), any()))
              .thenAnswer((_) async => Left(ServerFailure()));
          return cubit;
        },
        act: (cubit) => cubit.loadSearchImages(query),
        expect: () => [isA<FeedLoading>(), isA<FeedError>()],
      );
    });
  });
}
