import 'package:equatable/equatable.dart';
import 'package:ots_pocket/models/user_details_model.dart';

abstract class GetLoggedinUserDetailsState extends Equatable {
  const GetLoggedinUserDetailsState();

  @override
  List<Object> get props => [];
}

class GetLoggedinUserDetailsInitialState extends GetLoggedinUserDetailsState {
  @override
  String toString() => "GetLoggedinUserDetailsInitialState";
}

class GetLoggedinUserDetailsLoadingState extends GetLoggedinUserDetailsState {
  @override
  String toString() => "GetLoggedinUserDetailsLoadingState";
}

class GetLoggedinUserDetailsLoadedState extends GetLoggedinUserDetailsState {
  final UserDetails? userDetails;

  GetLoggedinUserDetailsLoadedState({this.userDetails});

  @override
  String toString() => "GetLoggedinUserDetailsLoadedState";
}

class GetLoggedinUserDetailsErrorState extends GetLoggedinUserDetailsState {
  final String errorMsg;
  GetLoggedinUserDetailsErrorState({required this.errorMsg});
  @override
  String toString() => "GetLoggedinUserDetailsErrorState";
}

class GetLoggedinUserDetailsEmptyState extends GetLoggedinUserDetailsState {
  @override
  String toString() => "GetLoggedinUserDetailsEmptyState";
}