import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_state.dart';
import 'package:ots_pocket/bloc/consumeable/consumeables_event.dart';
import 'package:ots_pocket/config/repo_factory.dart';

class AddNewConsumeableBloc
    extends Bloc<ConsumeableEvent, AddNewConsumeableState> {
  final RepoFactory? repoFactory;

  AddNewConsumeableBloc({this.repoFactory})
      : super(AddNewConsumeableInitialState()) {
    on<AddConsumeableEvent>(_getUserRegistrationEventCalled);
  }

  FutureOr<void> _getUserRegistrationEventCalled(
      AddConsumeableEvent event, Emitter<AddNewConsumeableState> emit) async {
    emit(AddNewConsumeableLoadingState());
    try {
      await RepoFactory()
          .getConsumeableRepository
          .addConsumeables(ConDetails: event.condetails);
      emit(AddNewConsumeableSuccessState());
    } catch (e) {
      log("UserRegistrationBloc : ${e.toString()}");
      emit(AddNewConsumeableFailedState(errorMsg: e.toString()));
    }
  }
}
