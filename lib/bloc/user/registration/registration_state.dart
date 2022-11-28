import 'package:equatable/equatable.dart';

abstract class UserRegistrationState extends Equatable {
  const UserRegistrationState();

  @override
  List<Object> get props => [];
}

class UserRegistrationInitialState extends UserRegistrationState {
  @override
  String toString() => "UserRegistrationInitialState";
}

class UserRegistrationLoadingState extends UserRegistrationState {
  @override
  String toString() => "UserRegistrationLoadingState";
}

class UserRegistrationSuccessState extends UserRegistrationState {
  @override
  String toString() => "UserRegistrationSuccessState";
}

class UserRegistrationFailedState extends UserRegistrationState {
  final String errorMsg;
  UserRegistrationFailedState({required this.errorMsg});
  @override
  String toString() => "UserRegistrationFailedState";
}
