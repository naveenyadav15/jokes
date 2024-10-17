part of 'random_joke.cubit.dart';

abstract class RandomJokeState extends Equatable {
  const RandomJokeState();
}

class RandomJokeInitial extends RandomJokeState {
  @override
  List<Object> get props => [];
}

class RandomJokeLoading extends RandomJokeState {
  @override
  List<Object> get props => [];
}

class RandomJokeLoaded extends RandomJokeState {
  final Joke joke;

  const RandomJokeLoaded(this.joke);

  @override
  List<Object> get props => [joke];
}

class RandomJokeError extends RandomJokeState {
  final String message;

  const RandomJokeError(this.message);

  @override
  List<Object> get props => [message];
}
