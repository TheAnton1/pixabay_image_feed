import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';
import 'package:feed_test/features/main_screen/domain/usecases/get_all_images.dart';
import 'package:feed_test/features/main_screen/domain/usecases/search_images.dart';
import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreenCubit extends Cubit<FeedScreenState> {
  final GetAllImages getAllImages;
  final SearchImages searchImages;

  int page = 1;

  FeedScreenCubit({required this.getAllImages, required this.searchImages})
      : super(FeedEmpty());

  Future<void> loadImages() async {
    if (state is FeedLoading) return;
    final currentState = state;
    var oldList = <CardEntity>[];
    if (currentState is FeedLoaded) {
      oldList = currentState.images;
    }
    emit(FeedLoading(isFirstFetch: page == 1, imageList: oldList));

    final result = await getAllImages.call(page);
    result.fold(
      (failure) {
        emit(
          FeedError(message: "Something went wrong: ${failure.toString()}. Try to off VPN."),
        );
      },
      (success) {
        page++;
        final images = (state as FeedLoading).imageList;
        images.addAll(success);
        emit(FeedLoaded(images: images));
      },
    );
  }

  Future<void> loadSearchImages(String query) async {
    if (state is FeedLoading) return;
    final currentState = state;
    var oldList = <CardEntity>[];
    if (currentState is FeedLoaded) {
      oldList = currentState.images;
    }
    emit(FeedLoading(isFirstFetch: page == 1, imageList: oldList));

    final result = await searchImages.call(query, page);
    result.fold((failure) {
      emit(
        FeedError(message: "Error while searching: ${failure.toString()}"),
      );
    }, (success) {
      page++;
      final searchedImages = (state as FeedLoading).imageList;
      searchedImages.addAll(success);
      emit(FeedLoaded(images: searchedImages));
    });
  }

  void clearFeed() {
    if (state is FeedLoaded) {
      emit(FeedEmpty());
      page = 1;
    }
  }
}
