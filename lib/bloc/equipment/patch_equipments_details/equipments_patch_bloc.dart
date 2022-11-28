import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/consumeables_event.dart';
import 'package:ots_pocket/bloc/consumeable/patch_consumable_details/consumable_patch_state.dart';
import 'package:ots_pocket/bloc/equipment/equpments_event.dart';
import 'package:ots_pocket/bloc/equipment/patch_equipments_details/equipments_patch_state.dart';
import 'package:ots_pocket/config/repo_factory.dart';

class EquipmentPatchBloc extends Bloc<EqupmentsEvent, EquipmentsPatchState> {
  final RepoFactory? repoFactory;

  EquipmentPatchBloc({this.repoFactory})
      : super(EquipmentsPatchInitialState()) {
    on<EquipmentPatchEvent>(_getEquipmentPatchEventCalled);
  }

  FutureOr<void> _getEquipmentPatchEventCalled(
      EquipmentPatchEvent event, Emitter<EquipmentsPatchState> emit) async {
    emit(EquipmentsPatchLoadingState());
    try {
      await RepoFactory()
          .getEquipmentRepository
          .patchEquipment(equipment: event.updateDetails);
      emit(EquipmentsPatchSuccessState());
    } catch (e) {
      log("UserPatchBloc : ${e.toString()}");
      emit(EquipmentsPatchFailedState(errorMsg: e.toString()));
    }
  }
}
