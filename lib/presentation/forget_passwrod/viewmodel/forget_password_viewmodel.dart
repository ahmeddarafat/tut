import 'dart:async';

import '../../../domain/usecase/forget_password_usecase.dart';
import '../../base/base_view_model.dart';
import '../../common/state_renderer/state_renderer.dart';

import '../../../app/functions.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  final ForgetPasswordUsecase _forgetPasswordUsecase;
  ForgetPasswordViewModel(this._forgetPasswordUsecase);

  late final StreamController<String> _emailStreamController;
  //// late final StreamController<bool> _areAllInputValidController;

  String email = "";

  @override
  void start() {
    stateInput.add(ContentState());
    _emailStreamController = StreamController.broadcast();
    //// _areAllInputValidController = StreamController();
  }

  @override
  void dispose() {
    _emailStreamController.close();
    //// _areAllInputValidController.close();
    super.dispose();
  }

  //* Inputs

  @override
  Sink<String> get emailInput => _emailStreamController.sink;

  ////@override
  //// Sink<bool> get areAllInputsValidInput => _areAllInputValidController.sink;

  @override
  setEmail(String email) {
    emailInput.add(email);
    this.email = email;
    //// areAllInputsValidInput.add(true);
  }

  @override
  forgetPassword() async {
    stateInput.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _forgetPasswordUsecase.execute(email)).fold(
      (failure) {
        return stateInput.add(
          ErrorState(
            stateRendererType: StateRendererType.popUpErrorState,
            message: failure.message,
          ),
        );
      },
      (supportMessage) {
        stateInput.add(
          SuccessState(
            message: supportMessage,
            stateRendererType: StateRendererType.popUpSuccessState,
          ),
        );
      },
    );
  }

  //*Outputs

  @override
  Stream<bool> get isEmailValidOutput =>
      _emailStreamController.stream.map((event) => isEmailValid(event));

  //// @override
  // // TODO: implement areAllInputsValidOutput
  //// Stream<bool> get areAllInputsValidOutput =>
  ////     _areAllInputValidController.stream;
}

abstract class ForgetPasswordViewModelInputs {
  setEmail(String email);
  forgetPassword();
  Sink<String> get emailInput;
  //// Sink<bool> get areAllInputsValidInput;
}

abstract class ForgetPasswordViewModelOutputs {
  Stream<bool> get isEmailValidOutput;
  //// Stream<bool> get areAllInputsValidOutput;
}
