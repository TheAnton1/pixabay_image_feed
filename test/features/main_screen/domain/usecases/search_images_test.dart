import 'package:dartz/dartz.dart';
import 'package:feed_test/core/network/failure.dart';
import 'package:feed_test/features/main_screen/domain/repositories/feed_repository.dart';
import 'package:feed_test/features/main_screen/domain/usecases/search_images.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../common/card_entity_example.dart';

class MockRepository extends Mock implements FeedRepository {}

void main() {
  late SearchImages usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SearchImages(feedRepository: mockRepository);
  });

  group("Search images usecase test", () {
    const int page = 1;
    const String query = "kittens";
    const cardEntityList = [CardEntityExamples.entityExample];
    test("should get a list of card entity", () async {
      when(() => mockRepository.getImages(query, page))
          .thenAnswer((invocation) async => const Right(cardEntityList));

      final result = await usecase.call(query, page);

      expect(result, equals(Right(cardEntityList)));
    });

    test("should get a server failure", () async {
      when(() => mockRepository.getImages(query, page))
          .thenAnswer((invocation) async => Left(ServerFailure()));

      final result = await usecase.call(query, page);

      expect(result, equals(Left(ServerFailure())));
    });
  });
}
