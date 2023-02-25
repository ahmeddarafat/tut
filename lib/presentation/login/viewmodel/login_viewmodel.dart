import 'dart:async';
import 'dart:developer';

import '../../../data/network/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/models/models.dart';
import '../../common/freezed_data_classes.dart';

import '../../../domain/usecase/login_usecase.dart';
import '../../base/base_view_model.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  // broadcast means that this stream has multiLetsiner
  final StreamController<String> _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  LoginObject loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  //* Inputs

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  Sink get userNameInput => _userNameStreamController.sink;

  @override
  Sink get passwordInputs => _passwordStreamController.sink;

  @override
  Sink get areAllInputsValidInput => _areAllInputsValidStreamController.sink;

  @override
  setUserName(String userName) {
    userNameInput.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    areAllInputsValidInput.add(null);
  }

  @override
  setPassword(String password) {
    passwordInputs.add(password);
    loginObject = loginObject.copyWith(password: password);
    areAllInputsValidInput.add(null);
  }

  @override
  login() async {
    Either<Failure, AuthenticationModel> either = await _loginUseCase
        .execute(LoginUseCaseInput(loginObject.userName, loginObject.password));
    // TODO: Explanation , Either
    // [1] fold is a mehtod belong to either class
    // [2] means if left return ...,if right return ...
    // [3] B fold<B>(B Function(Failure) ifLeft, B Function(AuthenticationModel) ifRight)
    // [4] B is null until you determine a specific type like this ex: either.fold<boo>()
    either.fold((failure) {
      log(failure.message);
    }, (authenticationModel) {
      log(authenticationModel.customer?.name ?? "null");
    });
  }

  //* Outputs

  @override
  Stream<bool> get isUserNameValidOutput =>
      _userNameStreamController.stream.map(_isUserNameValid);

  @override
  Stream<bool> get isPasswordValidOutput =>
      _passwordStreamController.stream.map(_isPasswordValid);
  @override
  Stream<bool> get areAllInputsValidOutput =>
      _areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  /// userName & password are String but I use dynamic to make methods valid for map method of stream
  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUserNameValid(loginObject.userName) ||
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
// those inputs (things that user gives them to you) that you will apply at login view (page)
  setUserName(String userName);
  setPassword(String password);

// better naming : clickLoginButton
  login();

// the inputs that is responsible for giving the outputs
// Sink is the pipe that you give an input (stream of inputs) from side
// then, you can listen from another side
  Sink get userNameInput;
  Sink get passwordInputs;
  Sink get areAllInputsValidInput;
}

abstract class LoginViewModelOutputs {
  // those outputs (things that you gives them to user) that you will appear at login view
  Stream<bool> get isUserNameValidOutput;
  Stream<bool> get isPasswordValidOutput;
  Stream<bool> get areAllInputsValidOutput;
}
