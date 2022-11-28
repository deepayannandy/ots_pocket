import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/bloc/user/registration/registration_state.dart';
import 'package:ots_pocket/config/repo_factory.dart';

class UserRegistrationBloc extends Bloc<UserEvent, UserRegistrationState> {
  final RepoFactory? repoFactory;

  UserRegistrationBloc({this.repoFactory})
      : super(UserRegistrationInitialState()) {
    on<UserRegistrationEvent>(_getUserRegistrationEventCalled);
  }

  FutureOr<void> _getUserRegistrationEventCalled(
      UserRegistrationEvent event, Emitter<UserRegistrationState> emit) async {
    emit(UserRegistrationLoadingState());
    try {
      await RepoFactory()
          .getUserRepository
          .registerUser(userDetails: event.userDetails);
      emit(UserRegistrationSuccessState());
    } catch (e) {
      log("UserRegistrationBloc : ${e.toString()}");
      emit(UserRegistrationFailedState(errorMsg: e.toString()));
    }
  }
}
