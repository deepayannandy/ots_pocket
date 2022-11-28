import 'package:equatable/equatable.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/equipments_model.dart';

abstract class GetEquipmentsDetailsState extends Equatable {
  const GetEquipmentsDetailsState();

  @override
  List<Object> get props => [];
}

class GetEquipmentsDetailsInitialState extends GetEquipmentsDetailsState {
  @override
  String toString() => "GetequipmentsDetailsInitialState";
}

class GetEquipmentsDetailsLoadingState extends GetEquipmentsDetailsState {
  @override
  String toString() => "GetEquipmentsDetailsLoadingState";
}

class GetEquipmentsDetailsLoadedState extends GetEquipmentsDetailsState {
  final List<equipmentsDetails>? EquipementDetailsList;

  GetEquipmentsDetailsLoadedState({this.EquipementDetailsList});

  @override
  String toString() => "GetEquipmentsDetailsLoadedState";
}

class GetEquipmentsDetailsErrorState extends GetEquipmentsDetailsState {
  final String errorMsg;
  GetEquipmentsDetailsErrorState({required this.errorMsg});
  @override
  String toString() => "GetEquipmentsDetailsErrorState";
}

class GetEquipmentsDetailsEmptyState extends GetEquipmentsDetailsState {
  @override
  String toString() => "GetEquipmentsDetailsEmptyState";
}
