import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/consumeables_event.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_state.dart';
import 'package:ots_pocket/config/repo_factory.dart';
import 'package:ots_pocket/models/consumeables_model.dart';

class GetConsumableBloc
    extends Bloc<ConsumeableEvent, GetConsumeableDetailsState> {
  final RepoFactory? repoFactory;

  GetConsumableBloc({this.repoFactory})
      : super(GetConsumeableDetailsInitialState()) {
    on<GetConsumeablesDetailsEvent>(_getConsumeableDetailsEventCalled);
  }

  FutureOr<void> _getConsumeableDetailsEventCalled(
      GetConsumeablesDetailsEvent event,
      Emitter<GetConsumeableDetailsState> emit) async {
    emit(GetConsumeableDetailsLoadingState());
    try {
      List<ConsumeablesDetails> conDetailsList =
          await RepoFactory().getConsumeableRepository.getConsumeabless();
      emit(GetConsumeablesDetailsLoadedState(
          ConsumeableDetailsList: conDetailsList));
    } catch (e) {
      log("GetConsumeablesBloc : ${e.toString()}");
      emit(GetConsumeableDetailsErrorState(errorMsg: e.toString()));
    }
  }
}
