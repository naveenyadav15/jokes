import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/domain/usecases/get_random_joke.dart';
import 'package:jokes/domain/usecases/search_jokes.dart';
import 'package:jokes/presentation/cubit/random_joke/random_joke.cubit.dart';
import 'package:jokes/presentation/cubit/search_joke/search_joke.cubit.dart';
import 'package:jokes/presentation/pages/joke_page.dart';
import 'package:mockito/mockito.dart';

class MockGetRandomJoke extends Mock implements GetRandomJoke {}

class MockSearchJokes extends Mock implements SearchJokes {}

void main() {
  final sl = GetIt.instance;

  setUp(() {
    sl.registerLazySingleton<GetRandomJoke>(() => MockGetRandomJoke());
    sl.registerLazySingleton<SearchJokes>(() => MockSearchJokes());
  });

  tearDown(() {
    sl.reset();
  });

  testWidgets('JokePage shows loading and then displays a joke',
      (WidgetTester tester) async {
    final randomJokeCubit = RandomJokeCubit(getRandomJoke: sl<GetRandomJoke>());
    final searchJokeCubit = SearchJokeCubit(searchJokes: sl<SearchJokes>());

    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<RandomJokeCubit>.value(value: randomJokeCubit),
            BlocProvider<SearchJokeCubit>.value(value: searchJokeCubit),
          ],
          child: const JokePage(),
        ),
      ),
    );

    expect(find.text('Press the button to get a joke!'), findsOneWidget);

    randomJokeCubit.emit(RandomJokeLoading());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    randomJokeCubit
        .emit(const RandomJokeLoaded(Joke(id: '123', joke: 'Funny joke!')));
    await tester.pump();

    expect(find.text('Funny joke!'), findsOneWidget);
  });
}
