import 'package:equatable/equatable.dart';
import 'package:ots_pocket/models/user_details_model.dart';

abstract class GetUserDetailsState extends Equatable {
  const GetUserDetailsState();

  @override
  List<Object> get props => [];
}

class GetUserDetailsInitialState extends GetUserDetailsState {
  @override
  String toString() => "GetUserDetailsInitialState";
}

class GetUserDetailsLoadingState extends GetUserDetailsState {
  @override
  String toString() => "GetUserDetailsLoadingState";
}

class GetUserDetailsLoadedState extends GetUserDetailsState {
  final List<UserDetails>? userDetailsList;

  GetUserDetailsLoadedState({this.userDetailsList});

  @override
  String toString() => "GetUserDetailsLoadedState";
}

class GetUserDetailsErrorState extends GetUserDetailsState {
  final String errorMsg;
  GetUserDetailsErrorState({required this.errorMsg});
  @override
  String toString() => "GetUserDetailsErrorState";
}

class GetUserDetailsEmptyState extends GetUserDetailsState {
  @override
  String toString() => "GetUserDetailsEmptyState";
}