import 'package:equatable/equatable.dart';
import 'package:ots_pocket/models/consumeables_model.dart';

abstract class GetConsumeableDetailsState extends Equatable {
  const GetConsumeableDetailsState();

  @override
  List<Object> get props => [];
}

class GetConsumeableDetailsInitialState extends GetConsumeableDetailsState {
  @override
  String toString() => "GetConsumeableDetailsInitialState";
}

class GetConsumeableDetailsLoadingState extends GetConsumeableDetailsState {
  @override
  String toString() => "GetConsumeableDetailsLoadingState";
}

class GetConsumeablesDetailsLoadedState extends GetConsumeableDetailsState {
  final List<ConsumeablesDetails>? ConsumeableDetailsList;

  GetConsumeablesDetailsLoadedState({this.ConsumeableDetailsList});

  @override
  String toString() => "GetConsumeableDetailsLoadedState";
}

class GetConsumeableDetailsErrorState extends GetConsumeableDetailsState {
  final String errorMsg;
  GetConsumeableDetailsErrorState({required this.errorMsg});
  @override
  String toString() => "GetConsumeableDetailsErrorState";
}

class GetConsumeableDetailsEmptyState extends GetConsumeableDetailsState {
  @override
  String toString() => "GetConsumeableDetailsEmptyState";
}
