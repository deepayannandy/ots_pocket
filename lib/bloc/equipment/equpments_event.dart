import 'package:equatable/equatable.dart';
import 'package:ots_pocket/approve_User.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/models/user_approval_details_model.dart';
import 'package:ots_pocket/models/user_registration_model.dart';

class EquipmentsEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const EquipmentsEvent();
}

class AddEquipmentEvent extends EquipmentsEvent {
  final equipmentsDetails equipdata;
  AddEquipmentEvent({required this.equipdata});
}

class EquipmentPatchEvent extends EquipmentsEvent {
  final equipmentsDetails updateDetails;
  EquipmentPatchEvent({required this.updateDetails});
}

class GetEqupmentsDetailsEvent extends EquipmentsEvent {}

class GetSpecificEqupmentDetailsEvent extends EquipmentsEvent {
  final String eid;
  GetSpecificEqupmentDetailsEvent({required this.eid});
}
