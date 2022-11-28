import 'package:equatable/equatable.dart';

abstract class UserPatchState extends Equatable {
  const UserPatchState();

  @override
  List<Object> get props => [];
}

class UserPatchInitialState extends UserPatchState {
  @override
  String toString() => "UserPatchInitialState";
}

class UserPatchLoadingState extends UserPatchState {
  @override
  String toString() => "UserPatchLoadingState";
}

class UserPatchSuccessState extends UserPatchState {
  @override
  String toString() => "UserPatchSuccessState";
}

class UserPatchFailedState extends UserPatchState {
  final String errorMsg;
  UserPatchFailedState({required this.errorMsg});
  @override
  String toString() => "UserPatchFailedState";
}
