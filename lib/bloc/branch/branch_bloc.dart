import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/branch/branch_event.dart';
import 'package:ots_pocket/bloc/branch/branch_state.dart';
import 'package:ots_pocket/config/repo_factory.dart';
import 'package:ots_pocket/models/branch_model.dart';
import 'package:ots_pocket/repos/branch_repository.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  final RepoFactory? repoFactory;

  BranchBloc({this.repoFactory}) : super(BranchInitialState()) {
    on<GetBranchEvent>(_getBranchEventCalled);
  }

  FutureOr<void> _getBranchEventCalled(
      GetBranchEvent event, Emitter<BranchState> emit) async {
    emit(BranchLoadingState());
    try {
      List<Branch> branchList =
          await RepoFactory().getBranchRepository.getBranchDetails();

      if (branchList.length == 0) {
        emit(BranchEmptyState());
      } else {
        emit(BranchLoadedState(branchList: branchList));
      }
    } catch (e) {
      emit(BranchErrorState());
    }
  }
}
