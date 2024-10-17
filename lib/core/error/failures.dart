import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  String get message; // Default message for the failure

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  @override
  String get message => 'Server error. Please try again later.';
}

class NetworkFailure extends Failure {
  @override
  String get message =>
      'No internet connection. Please check your network and try again.';
}

class TimeoutFailure extends Failure {
  @override
  String get message => 'Request timed out. Please try again.';
}

class UnexpectedFailure extends Failure {
  final String customMessage;

  const UnexpectedFailure([this.customMessage = 'Unable to fetch data']);

  @override
  String get message => customMessage;
}
