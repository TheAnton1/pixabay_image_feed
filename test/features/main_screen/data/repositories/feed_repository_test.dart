import 'package:dartz/dartz.dart';
import 'package:feed_test/core/network/exceptions.dart';
import 'package:feed_test/core/network/failure.dart';
import 'package:feed_test/features/main_screen/data/datasources/remote_data_source.dart';
import 'package:feed_test/features/main_screen/data/models/card_model.dart';
import 'package:feed_test/features/main_screen/data/repositories/feed_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../common/card_entity_example.dart';

class MockRemoteDataSource extends Mock implements ImageRemoteDataSource {}

void main() {
  late FeedRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = FeedRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group("Feed repository tests", () {
    const CardModel cardExample = CardEntityExamples.modelExample;
    final List<CardModel> listCardEntity = [cardExample];
    const int page = 1;
    const String query = "kittens";
    test("get all images: success", () async {
      when(() => mockRemoteDataSource.getAllImages(page))
          .thenAnswer((_) async => listCardEntity);

      final result = await repository.getImages(null, page);

      verify(() => mockRemoteDataSource.getAllImages(page));
      expect(result, equals(Right(listCardEntity)));
    });

    test("get all images: failure", () async {
      when(() => mockRemoteDataSource.getAllImages(page))
          .thenThrow(ServerException());

      final result = await repository.getImages(null, page);

      expect(result, equals(Left(ServerFailure())));
    });

    test("search images: success", () async {
      when(() => mockRemoteDataSource.searchImages(query, page))
          .thenAnswer((_) async => listCardEntity);

      final result = await repository.getImages(query, page);

      expect(result, equals(Right(listCardEntity)));
    });

    test("search images: failure", () async {
      when(() => mockRemoteDataSource.searchImages(query, page))
          .thenThrow(ServerException());

      final result = await repository.getImages(query, page);

      expect(result, equals(Left(ServerFailure())));
    });
  });
}
