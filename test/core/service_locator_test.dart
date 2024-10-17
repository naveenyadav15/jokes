import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:jokes/core/service_locator.dart';
import 'package:jokes/data/data_sources/joke_remote_data_source.dart';
import 'package:jokes/data/repo/joke_repo_impl.dart';
import 'package:jokes/domain/repo/joke_repo.dart';
import 'package:jokes/domain/usecases/get_random_joke.dart';
import 'package:jokes/domain/usecases/search_jokes.dart';

void main() {
  setUp(() {
    sl.reset();
    init();
  });

  tearDown(() {
    sl.reset();
  });

  test('should register all dependencies correctly', () {
    expect(sl.isRegistered<http.Client>(), true);

    expect(sl.isRegistered<JokeRemoteDataSource>(), true);

    expect(sl.isRegistered<JokeRepository>(), true);

    expect(sl.isRegistered<GetRandomJoke>(), true);

    expect(sl.isRegistered<SearchJokes>(), true);
  });

  test('should resolve registered dependencies correctly', () {
    final client = sl<http.Client>();
    expect(client, isA<http.Client>());

    final remoteDataSource = sl<JokeRemoteDataSource>();
    expect(remoteDataSource, isA<JokeRemoteDataSourceImpl>());

    final repository = sl<JokeRepository>();
    expect(repository, isA<JokeRepositoryImpl>());

    final getRandomJoke = sl<GetRandomJoke>();
    expect(getRandomJoke, isA<GetRandomJoke>());

    final searchJokes = sl<SearchJokes>();
    expect(searchJokes, isA<SearchJokes>());
  });
}
