import 'dart:developer';

import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_cubit.dart';
import 'package:feed_test/features/main_screen/presentation/ui/feed_screen_ui.dart';
import 'package:feed_test/service_locator.dart' as service_locator;
import 'package:feed_test/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    log('${event.level.name}: ${event.time}: ${event.message}');
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  service_locator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedScreenCubit>(
      create: (context) => sl<FeedScreenCubit>()..loadImages(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const FeedScreenUI(),
      ),
    );
  }
}
