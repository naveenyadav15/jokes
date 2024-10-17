import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/presentation/cubit/random_joke/random_joke.cubit.dart';

void main() {
  test('RandomJokeInitial should have correct properties', () {
    expect(RandomJokeInitial(), isA<RandomJokeInitial>());
  });

  test('RandomJokeLoading should have correct properties', () {
    expect(RandomJokeLoading(), isA<RandomJokeLoading>());
  });

  test('RandomJokeLoaded should have correct properties', () {
    const joke = Joke(joke: 'This is a joke');
    expect(const RandomJokeLoaded(joke), isA<RandomJokeLoaded>());
  });

  test('RandomJokeError should have correct properties', () {
    expect(const RandomJokeError('Error message'), isA<RandomJokeError>());
  });
}
