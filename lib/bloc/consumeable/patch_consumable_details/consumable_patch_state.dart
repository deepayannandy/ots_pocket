import 'package:equatable/equatable.dart';

abstract class ConsumablePatchState extends Equatable {
  const ConsumablePatchState();

  @override
  List<Object> get props => [];
}

class ConsumalePatchInitialState extends ConsumablePatchState {
  @override
  String toString() => "ConsumablePatchInitialState";
}

class ConsumablePatchLoadingState extends ConsumablePatchState {
  @override
  String toString() => "ConsumablePatchLoadingState";
}

class ConsumablePatchSuccessState extends ConsumablePatchState {
  @override
  String toString() => "ConsumablePatchSuccessState";
}

class ConsumablePatchFailedState extends ConsumablePatchState {
  final String errorMsg;
  ConsumablePatchFailedState({required this.errorMsg});
  @override
  String toString() => "ConsumablePatchFailedState";
}
