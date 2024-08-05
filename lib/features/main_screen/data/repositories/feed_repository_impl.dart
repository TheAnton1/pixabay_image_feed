import 'package:dartz/dartz.dart';
import 'package:feed_test/core/network/exceptions.dart';
import 'package:feed_test/core/network/failure.dart';
import 'package:feed_test/features/main_screen/data/datasources/remote_data_source.dart';
import 'package:feed_test/features/main_screen/data/models/card_model.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';
import 'package:feed_test/features/main_screen/domain/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final ImageRemoteDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CardEntity>>> getImages(String? query, int page) async {
    return await _getImages(() {
      if (query == null) {
        return remoteDataSource.getAllImages(page);
      } else {
        return remoteDataSource.searchImages(query, page);
      }
    });
  }

  Future<Either<Failure, List<CardModel>>> _getImages(
      Future<List<CardModel>> Function() getImages) async {
        try {
          final images = await getImages();
          return Right(images);
        } on ServerException {
          return Left(ServerFailure());
        } 
      }
}
