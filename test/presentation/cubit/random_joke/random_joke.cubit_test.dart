import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/core/error/failures.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/domain/usecases/get_random_joke.dart';
import 'package:jokes/presentation/cubit/random_joke/random_joke.cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRandomJoke extends Mock implements GetRandomJoke {}

void main() {
  late RandomJokeCubit cubit;
  late MockGetRandomJoke mockGetRandomJoke;

  setUp(() {
    mockGetRandomJoke = MockGetRandomJoke();
    cubit = RandomJokeCubit(getRandomJoke: mockGetRandomJoke);
  });

  group('RandomJokeCubit', () {
    test('initial state should be RandomJokeInitial', () {
      expect(cubit.state, RandomJokeInitial());
    });

    test(
        'should emit [RandomJokeLoading, RandomJokeLoaded] when fetchRandomJoke is successful',
        () async {
      const joke = Joke(joke: 'This is a joke');
      when(() => mockGetRandomJoke()).thenAnswer((_) async => Right(joke));

      expectLater(
          cubit.stream,
          emitsInOrder([
            RandomJokeLoading(),
            isA<RandomJokeLoaded>(),
          ]));

      await cubit.fetchRandomJoke();
    });

    test(
        'should emit [RandomJokeLoading, RandomJokeError] when fetchRandomJoke fails',
        () async {
      when(() => mockGetRandomJoke())
          .thenAnswer((_) async => const Left(UnexpectedFailure()));

      expectLater(
          cubit.stream,
          emitsInOrder([
            RandomJokeLoading(),
            isA<RandomJokeError>(),
          ]));

      await cubit.fetchRandomJoke();
    });
  });
}
