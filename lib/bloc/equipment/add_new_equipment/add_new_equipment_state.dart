import 'package:equatable/equatable.dart';

abstract class AddNewEquipmentsState extends Equatable {
  const AddNewEquipmentsState();

  @override
  List<Object> get props => [];
}

class AddNewEquipmentsInitialState extends AddNewEquipmentsState {
  @override
  String toString() => "AddNewEqupmentsInitialState";
}

class AddNewEquipmentsLoadingState extends AddNewEquipmentsState {
  @override
  String toString() => "AddNewEqupmentsLoadingState";
}

class AddNewEquipmentSuccessState extends AddNewEquipmentsState {
  @override
  String toString() => "AddNewEqupmentsSuccessState";
}

class AddNewEquipmentsFailedState extends AddNewEquipmentsState {
  final String errorMsg;
  AddNewEquipmentsFailedState({required this.errorMsg});
  @override
  String toString() => "AddNewEqupmentsFailedState";
}
