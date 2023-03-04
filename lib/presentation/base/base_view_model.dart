import 'dart:async';

import 'package:tut/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel with BaseViewModelInputs, BaseViewModelOutputs {

  // To control the States
  final StreamController<FlowState> _stateStreamController =
      StreamController.broadcast();

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
