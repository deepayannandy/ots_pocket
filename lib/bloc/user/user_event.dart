import 'package:equatable/equatable.dart';
import 'package:ots_pocket/models/user_approval_details_model.dart';
import 'package:ots_pocket/models/user_registration_model.dart';

class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const UserEvent();
}

class UserRegistrationEvent extends UserEvent {
  final UserRegistration userDetails;
  UserRegistrationEvent({required this.userDetails});
}

class UserPatchEvent extends UserEvent {
  final UserApprovalDetails approvalDetails;
  UserPatchEvent({required this.approvalDetails});
}

class UserDeleteEvent extends UserEvent {
  final String userid;
  UserDeleteEvent({required this.userid});
}

class GetUserDetailsEvent extends UserEvent {}

class GetLoggedinUserDetailsEvent extends UserEvent {}
