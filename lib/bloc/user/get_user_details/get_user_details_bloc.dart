import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/user/get_user_details/get_user_details_state.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/config/repo_factory.dart';
import 'package:ots_pocket/models/user_details_model.dart';

class GetUserDetailsUserBloc extends Bloc<UserEvent, GetUserDetailsState> {
  final RepoFactory? repoFactory;

  GetUserDetailsUserBloc({this.repoFactory})
      : super(GetUserDetailsInitialState()) {
    on<GetUserDetailsEvent>(_getUserDetailsEventCalled);
  }

  FutureOr<void> _getUserDetailsEventCalled(
      GetUserDetailsEvent event, Emitter<GetUserDetailsState> emit) async {
    emit(GetUserDetailsLoadingState());
    try {
      List<UserDetails> userDetailsList = await RepoFactory().getUserRepository.getUserDetails();
      emit(GetUserDetailsLoadedState(userDetailsList: userDetailsList));
    } catch (e) {
      log("UserRegistrationBloc : ${e.toString()}");
      emit(GetUserDetailsErrorState(errorMsg: e.toString()));
    }
  }
}
