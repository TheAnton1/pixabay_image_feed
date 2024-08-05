import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}
class UnexpectedFailure extends Failure {
  final String message;

  UnexpectedFailure({required this.message});
}