import '../../domain/entities/joke.dart';

class JokeModel extends Joke {
  const JokeModel({required super.id, required super.joke});

  factory JokeModel.fromJson(Map<String, dynamic> json) => JokeModel(
        id: json['id'],
        joke: json['joke'],
      );
}
