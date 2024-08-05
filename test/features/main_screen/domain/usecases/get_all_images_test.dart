import 'package:dartz/dartz.dart';
import 'package:feed_test/core/network/failure.dart';
import 'package:feed_test/features/main_screen/domain/repositories/feed_repository.dart';
import 'package:feed_test/features/main_screen/domain/usecases/get_all_images.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../common/card_entity_example.dart';

class MockRepository extends Mock implements FeedRepository {}

void main() {
  late GetAllImages usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetAllImages(feedRepository: mockRepository);
  });

  group("Search images usecase test", () {
    const int page = 1;
    const cardEntityList = [CardEntityExamples.entityExample];
    test("should get a list of card entity", () async {
      when(() => mockRepository.getImages(null, page))
          .thenAnswer((invocation) async => const Right(cardEntityList));

      final result = await usecase.call(page);

      expect(result, equals(const Right(cardEntityList)));
    });

    test("should get a server failure", () async {
      when(() => mockRepository.getImages(null, page))
          .thenAnswer((invocation) async => Left(ServerFailure()));

      final result = await usecase.call(page);

      expect(result, equals(Left(ServerFailure())));
    });
  });
}
