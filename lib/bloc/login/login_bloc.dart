import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/login/login_event.dart';
import 'package:ots_pocket/bloc/login/login_state.dart';
import 'package:ots_pocket/config/repo_factory.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RepoFactory? repoFactory;

  LoginBloc({this.repoFactory}) : super(LoginInitialState()) {
    on<LoadingLoginEvent>(_getLoadingLoginEventEventCalled);
  }

  FutureOr<void> _getLoadingLoginEventEventCalled(
      LoadingLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      await RepoFactory()
          .getLoginRepository
          .login(loginDetails: event.loginDetails);
      emit(LoginSuccessState());
    } catch (e) {
      log("LoginBloc : ${e.toString()}");
      emit(LoginFailedState(errorMsg: e.toString()));
    }
  }
}
