import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/core/error/failures.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/domain/usecases/search_jokes.dart';
import 'package:jokes/presentation/cubit/search_joke/search_joke.cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchJokes extends Mock implements SearchJokes {}

void main() {
  late SearchJokeCubit cubit;
  late MockSearchJokes mockSearchJokes;

  setUp(() {
    mockSearchJokes = MockSearchJokes();
    cubit = SearchJokeCubit(searchJokes: mockSearchJokes);
  });

  group('SearchJokeCubit', () {
    test('initial state should be SearchJokeInitial', () {
      expect(cubit.state, SearchJokeInitial());
    });

    test(
        'should emit [SearchJokeLoading, SearchJokeLoaded] when getSearchJokes is successful',
        () async {
      final jokes = [const Joke(joke: 'Joke 1'), const Joke(joke: 'Joke 2')];
      when(() => mockSearchJokes(any())).thenAnswer((_) async => Right(jokes));

      expectLater(
          cubit.stream,
          emitsInOrder([
            SearchJokeLoading(),
            isA<SearchJokeLoaded>(),
          ]));

      await cubit.getSearchJokes('Joke');
    });

    test(
        'should emit [SearchJokeLoading, SearchJokeError] when getSearchJokes fails',
        () async {
      when(() => mockSearchJokes(any()))
          .thenAnswer((_) async => const Left(UnexpectedFailure()));

      expectLater(
          cubit.stream,
          emitsInOrder([
            SearchJokeLoading(),
            isA<SearchJokeError>(),
          ]));

      await cubit.getSearchJokes('Joke');
    });
  });
}
