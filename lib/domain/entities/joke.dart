import 'package:equatable/equatable.dart';

class Joke extends Equatable {
  final String? id; // Make id nullable
  final String joke;

  const Joke({this.id, required this.joke}); // id is now optional

  @override
  List<Object?> get props => [id, joke];
}
