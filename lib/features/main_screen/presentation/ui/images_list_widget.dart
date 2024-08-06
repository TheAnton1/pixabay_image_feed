import 'package:feed_test/core/common/dimen.dart';
import 'package:feed_test/features/main_screen/domain/entity/card_entity.dart';
import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_cubit.dart';
import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_state.dart';
import 'package:feed_test/features/main_screen/presentation/ui/image_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesListWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final ScrollController scrollController = ScrollController();

  ImagesListWidget({required this.textEditingController, super.key});

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() async {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        if (textEditingController.text.isEmpty) {
          await context.read<FeedScreenCubit>().loadImages();
        } else {
          await context
              .read<FeedScreenCubit>()
              .loadSearchImages(textEditingController.text);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return BlocBuilder<FeedScreenCubit, FeedScreenState>(
      builder: (context, state) {
        List<CardEntity> images = <CardEntity>[];
        if (state is FeedLoading && state.isFirstFetch) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FeedLoading) {
          images = state.imageList;
        } else if (state is FeedLoaded) {
          images = state.images;
        } else if (state is FeedError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is FeedLoaded && state.images.isEmpty) {
          return const Center(
            child: Text("Nothing was found"),
          );
        }
        return GridView.builder(
          controller: scrollController,
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: Dimen.width350),
          itemBuilder: ((context, index) {
            return ImageCard(cardEntity: images[index]);
          }),
        );
      },
    );
  }
}
