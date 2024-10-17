import 'package:dartz/dartz.dart';
import 'package:jokes/core/error/failures.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/domain/repo/joke_repo.dart';

class SearchJokes {
  final JokeRepository repository;

  SearchJokes(this.repository);

  Future<Either<Failure, List<Joke>>> call(String query) async {
    return await repository.searchJokes(query);
  }
}
