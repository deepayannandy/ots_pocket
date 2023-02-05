import 'package:equatable/equatable.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/models/labor_rate_model.dart';

abstract class GetLaborRateState extends Equatable {
  const GetLaborRateState();

  @override
  List<Object> get props => [];
}

class GetLaborRateInitialState extends GetLaborRateState {
  @override
  String toString() => "GetLaborRateInitialState";
}

class GetLaborRateLoadingState extends GetLaborRateState {
  @override
  String toString() => "GetLaborRateLoadingState";
}

class GetLaborRateLoadedState extends GetLaborRateState {
  final List<LaborRate>? LaborRateList;

  GetLaborRateLoadedState({this.LaborRateList});

  @override
  String toString() => "GetLaborRateLoadedState";
}

class GetLaborRateErrorState extends GetLaborRateState {
  final String errorMsg;
  GetLaborRateErrorState({required this.errorMsg});
  @override
  String toString() => "GetLaborRateErrorState";
}

class GetLaborRateEmptyState extends GetLaborRateState {
  @override
  String toString() => "GetLaborRateEmptyState";
}
