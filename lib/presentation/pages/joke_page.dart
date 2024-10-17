import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/presentation/cubit/random_joke/random_joke.cubit.dart';
import 'package:jokes/presentation/cubit/search_joke/search_joke.cubit.dart';

class JokePage extends StatelessWidget {
  const JokePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f5f9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Random Joke",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                flex: 0,
                child: BlocBuilder<RandomJokeCubit, RandomJokeState>(
                  builder: (context, state) {
                    if (state is RandomJokeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RandomJokeLoaded) {
                      return JokeCard(joke: state.joke);
                    } else if (state is RandomJokeError) {
                      return Center(
                          child: Text(state.message,
                              style: const TextStyle(color: Colors.red)));
                    }
                    return const Center(
                        child: Text('Press the button to get a joke!'));
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Search Joke",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // Search field
              TextField(
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    context.read<SearchJokeCubit>().getSearchJokes(value);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search for jokes',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  suffixIcon:
                      const Icon(Icons.search, color: Colors.blueAccent),
                ),
              ),

              const SizedBox(height: 20),
              // Search Results
              BlocBuilder<SearchJokeCubit, SearchJokeState>(
                builder: (context, state) {
                  if (state is SearchJokeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchJokeLoaded) {
                    if (state.jokes.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Jokes found",
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.separated(
                        itemCount: state.jokes.length,
                        itemBuilder: (context, index) {
                          final joke = state.jokes[index];
                          return JokeCard(joke: joke);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 16);
                        },
                      ),
                    );
                  } else if (state is SearchJokeError) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(state.message,
                          style: const TextStyle(color: Colors.red)),
                    ));
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<RandomJokeCubit>().fetchRandomJoke();
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }
}

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Text(
        joke.joke,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }
}
