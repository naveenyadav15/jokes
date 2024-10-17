import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes/core/service_locator.dart';
import 'package:jokes/domain/usecases/get_random_joke.dart';
import 'package:jokes/domain/usecases/search_jokes.dart';
import 'package:jokes/presentation/cubit/random_joke/random_joke.cubit.dart';
import 'package:jokes/presentation/cubit/search_joke/search_joke.cubit.dart';
import 'package:jokes/presentation/pages/joke_page.dart';

void main() {
  init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RandomJokeCubit(getRandomJoke: sl<GetRandomJoke>())
            ..fetchRandomJoke(),
        ),
        BlocProvider(
          create: (_) => SearchJokeCubit(searchJokes: sl<SearchJokes>()),
        ),
      ],
      child: MaterialApp(
        title: 'Dad Jokes App',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: const JokePage(),
      ),
    );
  }
}
