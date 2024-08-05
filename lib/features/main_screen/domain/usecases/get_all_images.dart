import 'package:dartz/dartz.dart';
import 'package:feed_test/core/network/failure.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';
import 'package:feed_test/features/main_screen/domain/repositories/feed_repository.dart';

class GetAllImages {
  final FeedRepository feedRepository;

  GetAllImages({required this.feedRepository});

  Future<Either<Failure, List<CardEntity>>> call(int page) async { 
    return await feedRepository.getImages(null, page);
  }
}