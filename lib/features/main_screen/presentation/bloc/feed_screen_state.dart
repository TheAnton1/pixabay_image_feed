import 'package:equatable/equatable.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';

abstract class FeedScreenState extends Equatable {
  const FeedScreenState();

  @override
  List<Object?> get props => [];
}

class FeedEmpty extends FeedScreenState {}

class FeedLoading extends FeedScreenState {
  final List<CardEntity> imageList;
  final bool isFirstFetch;

  const FeedLoading({required this.isFirstFetch, required this.imageList});

  @override
  List<Object?> get props => [imageList];
}

class FeedLoaded extends FeedScreenState {
  final List<CardEntity> images;

  const FeedLoaded({required this.images});

  @override
  List<Object?> get props => [images];
}

class FeedError extends FeedScreenState {
  final String message;

  const FeedError({required this.message});

  @override
  List<Object?> get props => [message];
}

