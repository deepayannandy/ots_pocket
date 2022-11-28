import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/equipment/equpments_event.dart';
import 'package:ots_pocket/bloc/equipment/get_equipments_deyails/get_equipments_details_state.dart';
import 'package:ots_pocket/config/repo_factory.dart';
import 'package:ots_pocket/models/equipments_model.dart';

class GetEqupmentsBloc
    extends Bloc<GetEqupmentsDetailsEvent, GetEquipmentsDetailsState> {
  final RepoFactory? repoFactory;

  GetEqupmentsBloc({this.repoFactory})
      : super(GetEquipmentsDetailsInitialState()) {
    on<GetEqupmentsDetailsEvent>(_getEqupmentDetailsEventCalled);
  }

  FutureOr<void> _getEqupmentDetailsEventCalled(GetEqupmentsDetailsEvent event,
      Emitter<GetEquipmentsDetailsState> emit) async {
    emit(GetEquipmentsDetailsLoadingState());
    try {
      List<equipmentsDetails> equipDetailsList =
          await RepoFactory().getEquipmentRepository.getEquipments();
      emit(GetEquipmentsDetailsLoadedState(
          EquipementDetailsList: equipDetailsList));
    } catch (e) {
      log("GetEquipmentBloc : ${e.toString()}");
      emit(GetEquipmentsDetailsErrorState(errorMsg: e.toString()));
    }
  }
}
