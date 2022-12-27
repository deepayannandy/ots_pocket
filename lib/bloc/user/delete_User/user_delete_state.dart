import 'package:equatable/equatable.dart';

abstract class UserDeleteState extends Equatable {
  const UserDeleteState();

  @override
  List<Object> get props => [];
}

class UserDeleteInitialState extends UserDeleteState {
  @override
  String toString() => "UserDeleteInitialState";
}

class UserDeleteLoadingState extends UserDeleteState {
  @override
  String toString() => "UserDeleteLoadingState";
}

class UserDeleteSuccessState extends UserDeleteState {
  @override
  String toString() => "UserDeleteSuccessState";
}

class UserDeleteFailedState extends UserDeleteState {
  final String errorMsg;
  UserDeleteFailedState({required this.errorMsg});
  @override
  String toString() => "UserDeleteFailedState";
}
