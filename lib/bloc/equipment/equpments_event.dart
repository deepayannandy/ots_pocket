import 'package:equatable/equatable.dart';
import 'package:ots_pocket/approve_User.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/models/user_approval_details_model.dart';
import 'package:ots_pocket/models/user_registration_model.dart';

class EqupmentsEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const EqupmentsEvent();
}

// class AddConsumeableEvent extends ConsumeableEvent {
//   final UserRegistration userDetails;
//   AddConsumeableEvent({required this.userDetails});
// }

class EquipmentPatchEvent extends EqupmentsEvent {
  final equipmentsDetails updateDetails;
  EquipmentPatchEvent({required this.updateDetails});
}

class GetEqupmentsDetailsEvent extends EqupmentsEvent {}

class GetSpecificEqupmentDetailsEvent extends EqupmentsEvent {
  final String eid;
  GetSpecificEqupmentDetailsEvent({required this.eid});
}
