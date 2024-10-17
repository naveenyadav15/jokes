import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:jokes/core/error/exceptions.dart';
import 'package:jokes/data/models/joke_model.dart';

abstract class JokeRemoteDataSource {
  Future<JokeModel> getRandomJoke();
  Future<List<JokeModel>> searchJokes(String query);
}

class JokeRemoteDataSourceImpl implements JokeRemoteDataSource {
  final http.Client client;

  JokeRemoteDataSourceImpl({required this.client});

  @override
  Future<JokeModel> getRandomJoke() async {
    try {
      final response = await client.get(
        Uri.parse('https://icanhazdadjoke.com/'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return JokeModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } on http.ClientException {
      throw NetworkException();
    } on TimeoutException {
      throw TimeoutException();
    } on FormatException {
      throw ServerException();
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Unable to fetch Jokes');
    }
  }

  @override
  Future<List<JokeModel>> searchJokes(String query) async {
    try {
      final response = await client.get(
        Uri.parse('https://icanhazdadjoke.com/search?term=$query'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10)); // Adding a timeout

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['results'] as List)
            .map((joke) => JokeModel.fromJson(joke))
            .toList();
      } else {
        throw ServerException();
      }
    } on http.ClientException {
      throw NetworkException();
    } on TimeoutException {
      throw TimeoutException();
    } on FormatException {
      throw ServerException();
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw Exception('Not able to search jokes!'); // Generic catch-all
    }
  }
}
