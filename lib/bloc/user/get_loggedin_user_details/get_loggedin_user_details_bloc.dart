import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/config/repo_factory.dart';
import 'package:ots_pocket/models/user_details_model.dart';

import 'get_loggedin_user_details_state.dart';

class GetLoggedinUserDetailsBloc
    extends Bloc<UserEvent, GetLoggedinUserDetailsState> {
  final RepoFactory? repoFactory;

  GetLoggedinUserDetailsBloc({this.repoFactory})
      : super(GetLoggedinUserDetailsInitialState()) {
    on<GetLoggedinUserDetailsEvent>(_getLoggedInUserDetailsEventCalled);
  }

  FutureOr<void> _getLoggedInUserDetailsEventCalled(
      GetLoggedinUserDetailsEvent event,
      Emitter<GetLoggedinUserDetailsState> emit) async {
    emit(GetLoggedinUserDetailsLoadingState());
    try {
      UserDetails userDetails =
          await RepoFactory().getUserRepository.getMyDetails();
      emit(GetLoggedinUserDetailsLoadedState(userDetails: userDetails));
    } catch (e) {
      log("UserRegistrationBloc : ${e.toString()}");
      emit(GetLoggedinUserDetailsErrorState(errorMsg: e.toString()));
    }
  }
}
