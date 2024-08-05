import 'package:dartz/dartz.dart';
import 'package:feed_test/core/network/failure.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<CardEntity>>> getImages(String? query, int page);
}