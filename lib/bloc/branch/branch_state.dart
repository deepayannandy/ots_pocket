import 'package:equatable/equatable.dart';
import 'package:ots_pocket/models/branch_model.dart';

abstract class BranchState extends Equatable {
  const BranchState();

  @override
  List<Object> get props => [];
}

class BranchInitialState extends BranchState {
  @override
  String toString() => "BranchInitialState";
}

class BranchLoadingState extends BranchState {
  @override
  String toString() => "BranchLoadingState";
}

class BranchLoadedState extends BranchState {
  final List<Branch>? branchList;
  BranchLoadedState({this.branchList});

  @override
  String toString() => "BranchLoadedState";
}

class BranchEmptyState extends BranchState {
  @override
  String toString() => "BranchEmptyState";
}

class BranchErrorState extends BranchState {
  @override
  String toString() => "BranchErrorState";
}
