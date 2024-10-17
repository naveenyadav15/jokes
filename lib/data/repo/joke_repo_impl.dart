import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:jokes/core/error/exceptions.dart';
import 'package:jokes/core/error/failures.dart';
import 'package:jokes/data/data_sources/joke_remote_data_source.dart';
import 'package:jokes/domain/entities/joke.dart';
import 'package:jokes/domain/repo/joke_repo.dart';

class JokeRepositoryImpl implements JokeRepository {
  final JokeRemoteDataSource remoteDataSource;

  JokeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Joke>> getRandomJoke() async {
    try {
      final joke = await remoteDataSource.getRandomJoke();
      return Right(joke);
    } on NetworkException {
      return Left(NetworkFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on TimeoutException {
      return Left(TimeoutFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Joke>>> searchJokes(String query) async {
    try {
      final jokes = await remoteDataSource.searchJokes(query);
      return Right(jokes);
    } on NetworkException {
      return Left(NetworkFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on TimeoutException {
      return Left(TimeoutFailure());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
