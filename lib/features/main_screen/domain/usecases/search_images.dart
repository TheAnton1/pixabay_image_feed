import 'package:dartz/dartz.dart';
import 'package:feed_test/core/network/failure.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';
import 'package:feed_test/features/main_screen/domain/repositories/feed_repository.dart';

class SearchImages {
  final FeedRepository feedRepository;

  SearchImages({required this.feedRepository});

  Future<Either<Failure, List<CardEntity>>> call(String query, int page) async {
    return await feedRepository.getImages(query, page);
  }
}