import 'dart:async';

import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_cubit.dart';
import 'package:feed_test/features/main_screen/presentation/ui/images_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreenUI extends StatefulWidget {
  const FeedScreenUI({super.key});

  @override
  State<FeedScreenUI> createState() => _FeedScreenUIState();
}

class _FeedScreenUIState extends State<FeedScreenUI> {
  final TextEditingController textEditingController = TextEditingController();
  Timer? _debounce;
  static const _debounceDuration = 800;

  @override
  void dispose() {
    _debounce?.cancel();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            hintText: "Search...",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            context.read<FeedScreenCubit>().clearFeed();
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce =
                Timer(const Duration(milliseconds: _debounceDuration), () {
              context.read<FeedScreenCubit>().loadSearchImages(value);
            });
          },
        ),
      ),
      body: ImagesListWidget(
        textEditingController: textEditingController,
      ),
    );
  }
}
