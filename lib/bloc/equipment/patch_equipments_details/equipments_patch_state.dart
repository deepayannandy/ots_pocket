import 'package:equatable/equatable.dart';

abstract class EquipmentsPatchState extends Equatable {
  const EquipmentsPatchState();

  @override
  List<Object> get props => [];
}

class EquipmentsPatchInitialState extends EquipmentsPatchState {
  @override
  String toString() => "EquipmentsPatchInitialState";
}

class EquipmentsPatchLoadingState extends EquipmentsPatchState {
  @override
  String toString() => "EquipmentsPatchLoadingState";
}

class EquipmentsPatchSuccessState extends EquipmentsPatchState {
  @override
  String toString() => "EquipmentsPatchSuccessState";
}

class EquipmentsPatchFailedState extends EquipmentsPatchState {
  final String errorMsg;
  EquipmentsPatchFailedState({required this.errorMsg});
  @override
  String toString() => "EquipmentsPatchFailedState";
}
