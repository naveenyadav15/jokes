import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/presentation/cubit/search_joke/search_joke.cubit.dart';

void main() {
  test('SearchJokeInitial should have correct properties', () {
    expect(SearchJokeInitial(), isA<SearchJokeInitial>());
  });

  test('SearchJokeLoading should have correct properties', () {
    expect(SearchJokeLoading(), isA<SearchJokeLoading>());
  });

  test('SearchJokeLoaded should have correct properties', () {
    final jokes = [const Joke(joke: 'Joke 1')];
    expect(SearchJokeLoaded(jokes), isA<SearchJokeLoaded>());
  });

  test('SearchJokeError should have correct properties', () {
    expect(const SearchJokeError('Error message'), isA<SearchJokeError>());
  });
}
