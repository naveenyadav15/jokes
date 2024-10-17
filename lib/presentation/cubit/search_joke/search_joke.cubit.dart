import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/domain/usecases/search_jokes.dart';

part 'search_joke.state.dart';

class SearchJokeCubit extends Cubit<SearchJokeState> {
  final SearchJokes searchJokes;

  SearchJokeCubit({required this.searchJokes}) : super(SearchJokeInitial());

  Future<void> getSearchJokes(String query) async {
    emit(SearchJokeLoading());
    final result = await searchJokes(query);
    result.fold(
      (failure) {
        return emit(SearchJokeError(failure.message));
      },
      (jokes) => emit(SearchJokeLoaded(jokes)),
    );
  }
}
