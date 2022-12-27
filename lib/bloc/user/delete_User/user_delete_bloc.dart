import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/user/delete_User/user_delete_state.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/config/repo_factory.dart';

class UserDeleteBloc extends Bloc<UserEvent, UserDeleteState> {
  final RepoFactory? repoFactory;

  UserDeleteBloc({this.repoFactory}) : super(UserDeleteInitialState()) {
    on<UserDeleteEvent>(_getUserDeleteEventCalled);
  }

  FutureOr<void> _getUserDeleteEventCalled(
      UserDeleteEvent event, Emitter<UserDeleteState> emit) async {
    emit(UserDeleteLoadingState());
    try {
      await RepoFactory().getUserRepository.deleteUser(userid: event.userid);
      emit(UserDeleteSuccessState());
    } catch (e) {
      log("UserDeleteBloc : ${e.toString()}");
      emit(UserDeleteFailedState(errorMsg: e.toString()));
    }
  }
}
