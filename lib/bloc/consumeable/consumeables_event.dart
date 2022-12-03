import 'package:equatable/equatable.dart';
import 'package:ots_pocket/approve_User.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/user_approval_details_model.dart';
import 'package:ots_pocket/models/user_registration_model.dart';

class ConsumeableEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const ConsumeableEvent();
}

class AddConsumeableEvent extends ConsumeableEvent {
  final ConsumeablesDetails condetails;
  AddConsumeableEvent({required this.condetails});
}

class ConsumeablePatchEvent extends ConsumeableEvent {
  final ConsumeablesDetails updateDetails;
  ConsumeablePatchEvent({required this.updateDetails});
}

class GetConsumeablesDetailsEvent extends ConsumeableEvent {}

class GetSpecificConsumeableDetailsEvent extends ConsumeableEvent {
  final String cid;
  GetSpecificConsumeableDetailsEvent({required this.cid});
}
