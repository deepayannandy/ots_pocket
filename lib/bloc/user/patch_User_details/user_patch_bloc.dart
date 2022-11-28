import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/user/patch_User_details/user_patch_state.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/config/repo_factory.dart';

class UserPatchBloc extends Bloc<UserEvent, UserPatchState> {
  final RepoFactory? repoFactory;

  UserPatchBloc({this.repoFactory}) : super(UserPatchInitialState()) {
    on<UserPatchEvent>(_getUserPatchEventCalled);
  }

  FutureOr<void> _getUserPatchEventCalled(
      UserPatchEvent event, Emitter<UserPatchState> emit) async {
    emit(UserPatchLoadingState());
    try {
      await RepoFactory()
          .getUserRepository
          .patchUser(userDetails: event.approvalDetails);
      emit(UserPatchSuccessState());
    } catch (e) {
      log("UserPatchBloc : ${e.toString()}");
      emit(UserPatchFailedState(errorMsg: e.toString()));
    }
  }
}
