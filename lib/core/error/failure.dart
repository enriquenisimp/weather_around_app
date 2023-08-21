import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Failure extends Equatable {
  final String? message;
  const Failure(this.message);

  const Failure.unknown() : message = 'Something went wrong';

  @override
  List<Object?> get props => [message];
}
