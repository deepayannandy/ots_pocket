import 'package:equatable/equatable.dart';
import 'package:ots_pocket/models/login_model.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const LoginEvent();
}

class LoadingLoginEvent extends LoginEvent {
  final Login loginDetails;
  LoadingLoginEvent({required this.loginDetails});
}