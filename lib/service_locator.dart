import 'package:feed_test/features/main_screen/data/datasources/remote_data_source.dart';
import 'package:feed_test/features/main_screen/data/repositories/feed_repository_impl.dart';
import 'package:feed_test/features/main_screen/domain/repositories/feed_repository.dart';
import 'package:feed_test/features/main_screen/domain/usecases/get_all_images.dart';
import 'package:feed_test/features/main_screen/domain/usecases/search_images.dart';
import 'package:feed_test/features/main_screen/presentation/bloc/feed_screen_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC or Cubit
  sl.registerFactory(() => FeedScreenCubit(getAllImages: sl(), searchImages: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetAllImages(feedRepository: sl()));
  sl.registerLazySingleton(() => SearchImages(feedRepository: sl()));

  // Repo
  sl.registerLazySingleton<FeedRepository>(() => FeedRepositoryImpl(remoteDataSource: sl())); 
  sl.registerLazySingleton<ImageRemoteDataSource>(() => ImageRemoteDataSourceImpl(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}