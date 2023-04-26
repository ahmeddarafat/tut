import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel with BaseViewModelInputs, BaseViewModelOutputs {

  // To control the States
  //TODO: BehaviorSubject
  // todo: when using stream controller constructor, it make error not show loading
  // todo: and BehaviorSubject shows loading normaly
  final StreamController<FlowState> _stateStreamController =
      BehaviorSubject();

  @override
  Sink<FlowState> get stateInput => _stateStreamController.sink;

  @override
  Stream<FlowState> get stateOuput => _stateStreamController.stream;

  @override
  void dispose() {
    _stateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();

  Sink<FlowState> get stateInput;
}

abstract class BaseViewModelOutputs {

  Stream<FlowState> get stateOuput;
}
