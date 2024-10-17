import 'package:dartz/dartz.dart';
import 'package:jokes/core/error/failures.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/domain/repo/joke_repo.dart';

class GetRandomJoke {
  final JokeRepository repository;

  GetRandomJoke(this.repository);

  Future<Either<Failure, Joke>> call() async {
    return await repository.getRandomJoke();
  }
}
