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
    bool _isLoading = false;
    setupScrollController(context);

    return BlocBuilder<FeedScreenCubit, FeedScreenState>(
      builder: (context, state) {
        List<CardEntity> images = <CardEntity>[];
        if (state is FeedLoading && state.isFirstFetch) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FeedLoading) {
          _isLoading = true;
          images = state.imageList;
        } else if (state is FeedLoaded) {
          _isLoading = false;
          images = state.images;
        } else if (state is FeedError) {
          _isLoading = false;
          return Center(
            child: Text(state.message),
          );
        } else if (state is FeedEmpty) {
          _isLoading = false;
          return const Center(
            child: Text("Nothing was found"),
          );
        }
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Dimen.width350),
                itemBuilder: ((context, index) {
                  return ImageCard(cardEntity: images[index]);
                }),
              ),
            ),
            if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimen.paddingVertical20),
                    child: CircularProgressIndicator(),
                  ),
                
              ),
          ],
        );
      },
    );
  }
}
