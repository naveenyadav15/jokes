import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:jokes/data/data_sources/joke_remote_data_source.dart';
import 'package:jokes/data/repo/joke_repo_impl.dart';
import 'package:jokes/domain/repo/joke_repo.dart';
import 'package:jokes/domain/usecases/get_random_joke.dart';
import 'package:jokes/domain/usecases/search_jokes.dart';

final sl = GetIt.instance;

void init() {
  // Register the HTTP client
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Register the remote data source
  sl.registerLazySingleton<JokeRemoteDataSource>(
      () => JokeRemoteDataSourceImpl(client: sl()));

  // Register the repository
  sl.registerLazySingleton<JokeRepository>(
      () => JokeRepositoryImpl(remoteDataSource: sl()));

  // Register use cases
  sl.registerLazySingleton(() => GetRandomJoke(sl()));
  sl.registerLazySingleton(() => SearchJokes(sl()));
}
