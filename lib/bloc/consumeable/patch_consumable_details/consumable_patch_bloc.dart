import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/consumeables_event.dart';
import 'package:ots_pocket/bloc/consumeable/patch_consumable_details/consumable_patch_state.dart';
import 'package:ots_pocket/config/repo_factory.dart';

class ConsumablePatchBloc extends Bloc<ConsumeableEvent, ConsumablePatchState> {
  final RepoFactory? repoFactory;

  ConsumablePatchBloc({this.repoFactory})
      : super(ConsumalePatchInitialState()) {
    on<ConsumeablePatchEvent>(_getConsumablePatchEventCalled);
  }

  FutureOr<void> _getConsumablePatchEventCalled(
      ConsumeablePatchEvent event, Emitter<ConsumablePatchState> emit) async {
    emit(ConsumablePatchLoadingState());
    try {
      await RepoFactory()
          .getConsumeableRepository
          .patchConsumeables(consumeable: event.updateDetails);
      emit(ConsumablePatchSuccessState());
    } catch (e) {
      log("UserPatchBloc : ${e.toString()}");
      emit(ConsumablePatchFailedState(errorMsg: e.toString()));
    }
  }
}
