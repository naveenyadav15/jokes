import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/domain/usecases/get_random_joke.dart';

part 'random_joke.state.dart';

class RandomJokeCubit extends Cubit<RandomJokeState> {
  final GetRandomJoke getRandomJoke;

  RandomJokeCubit({required this.getRandomJoke}) : super(RandomJokeInitial());

  Future<void> fetchRandomJoke() async {
    emit(RandomJokeLoading());
    final result = await getRandomJoke();
    result.fold(
      (failure) => emit(RandomJokeError(failure.message)),
      (joke) => emit(RandomJokeLoaded(joke)),
    );
  }
}
