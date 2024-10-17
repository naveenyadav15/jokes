import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/joke.dart';

abstract class JokeRepository {
  Future<Either<Failure, Joke>> getRandomJoke();
  Future<Either<Failure, List<Joke>>> searchJokes(String query);
}
