import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/laborRate/getLaborRate/get_labor_rate_state.dart';
import 'package:ots_pocket/config/repo_factory.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/models/labor_rate_model.dart';

import '../labourRate_event.dart';

class GetLaborRateBloc extends Bloc<GetLaborRateEvent, GetLaborRateState> {
  final RepoFactory? repoFactory;

  GetLaborRateBloc({this.repoFactory}) : super(GetLaborRateInitialState()) {
    on<GetLaborRateEvent>(_getLaborRateEventCalled);
  }

  FutureOr<void> _getLaborRateEventCalled(
      GetLaborRateEvent event, Emitter<GetLaborRateState> emit) async {
    emit(GetLaborRateLoadingState());
    try {
      List<LaborRate> labourrate = await RepoFactory()
          .getLaborRateRepository
          .getLaborRate(catagory: event.catagory);
      emit(GetLaborRateLoadedState(LaborRateList: labourrate));
    } catch (e) {
      log("GetLaborRateBloc : ${e.toString()}");
      emit(GetLaborRateErrorState(errorMsg: e.toString()));
    }
  }
}
