import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/config/repo_factory.dart';

import '../equpments_event.dart';
import 'add_new_equipment_state.dart';

class AddNewEquipmentBloc extends Bloc<EquipmentsEvent, AddNewEquipmentsState> {
  final RepoFactory? repoFactory;

  AddNewEquipmentBloc({this.repoFactory})
      : super(AddNewEquipmentsInitialState()) {
    on<AddEquipmentEvent>(_postequipEventCalled);
  }

  FutureOr<void> _postequipEventCalled(
      AddEquipmentEvent event, Emitter<AddNewEquipmentsState> emit) async {
    emit(AddNewEquipmentsLoadingState());
    try {
      await RepoFactory()
          .getEquipmentRepository
          .addEquipment(EquipDetails: event.equipdata);
      emit(AddNewEquipmentSuccessState());
    } catch (e) {
      log("AddEquipmentBloc : ${e.toString()}");
      emit(AddNewEquipmentsFailedState(errorMsg: e.toString()));
    }
  }
}
