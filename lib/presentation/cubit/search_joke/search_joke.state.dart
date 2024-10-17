part of 'search_joke.cubit.dart';

abstract class SearchJokeState extends Equatable {
  const SearchJokeState();
}

class SearchJokeInitial extends SearchJokeState {
  @override
  List<Object> get props => [];
}

class SearchJokeLoading extends SearchJokeState {
  @override
  List<Object> get props => [];
}

class SearchJokeLoaded extends SearchJokeState {
  final List<Joke> jokes;

  const SearchJokeLoaded(this.jokes);

  @override
  List<Object> get props => [jokes];
}

class SearchJokeError extends SearchJokeState {
  final String message;

  const SearchJokeError(this.message);

  @override
  List<Object> get props => [message];
}
