import 'package:equatable/equatable.dart';

abstract class AddNewConsumeableState extends Equatable {
  const AddNewConsumeableState();

  @override
  List<Object> get props => [];
}

class AddNewConsumeableInitialState extends AddNewConsumeableState {
  @override
  String toString() => "AddNewConsumeableInitialState";
}

class AddNewConsumeableLoadingState extends AddNewConsumeableState {
  @override
  String toString() => "AddNewConsumeableLoadingState";
}

class AddNewConsumeableSuccessState extends AddNewConsumeableState {
  @override
  String toString() => "AddNewConsumeableSuccessState";
}

class AddNewConsumeableFailedState extends AddNewConsumeableState {
  final String errorMsg;
  AddNewConsumeableFailedState({required this.errorMsg});
  @override
  String toString() => "AddNewConsumeableFailedState";
}
