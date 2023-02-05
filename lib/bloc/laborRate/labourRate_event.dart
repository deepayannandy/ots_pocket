import 'package:equatable/equatable.dart';
import 'package:ots_pocket/approve_User.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/models/user_approval_details_model.dart';
import 'package:ots_pocket/models/user_registration_model.dart';

class LaborRateEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const LaborRateEvent();
}

// class AddEquipmentEvent extends LaborRateEvent {
//   final equipmentsDetails equipdata;
//   AddEquipmentEvent({required this.equipdata});
// }

// class EquipmentPatchEvent extends LaborRateEvent {
//   final equipmentsDetails updateDetails;
//   EquipmentPatchEvent({required this.updateDetails});
// }

class GetLaborRateEvent extends LaborRateEvent {
  final String catagory;
  GetLaborRateEvent({required this.catagory});
}

// class GetSpecificEqupmentDetailsEvent extends LaborRateEvent {
//   final String eid;
//   GetSpecificEqupmentDetailsEvent({required this.eid});
// }
