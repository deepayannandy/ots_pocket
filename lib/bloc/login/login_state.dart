import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {
  @override
  String toString() => "LoginInitialState";
}

class LoginLoadingState extends LoginState {
  @override
  String toString() => "LoginLoadingState";
}

class LoginSuccessState extends LoginState {
  @override
  String toString() => "LoginSuccessState";
}

class LoginFailedState extends LoginState {
  final String errorMsg;
  LoginFailedState({required this.errorMsg});
  @override
  String toString() => "LoginFailedState";
}
