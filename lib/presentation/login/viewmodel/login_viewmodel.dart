import 'dart:async';
import 'dart:developer';

import '../../../data/network/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/models/models.dart';
import '../../common/freezed_data_classes.dart';

import '../../../domain/usecase/login_usecase.dart';
import '../../base/base_view_model.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {

  // broadcast means that this stream has multiLetsiner
  final StreamController userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController passwordStreamController =
      StreamController<String>.broadcast();

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
    userNameStreamController.close();
    passwordStreamController.close();
  }

  @override
  Sink get userNameInputs => userNameStreamController.sink;

  @override
  Sink get passwordInputs => passwordStreamController.sink;

  @override
  setUserName(String userName) {
    userNameInputs.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
  }

  @override
  setPassword(String password) {
    passwordInputs.add(password);
    loginObject = loginObject.copyWith(password: password);
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
  Stream<bool> get isUserNameValidOutputs =>
      userNameStreamController.stream.map(isUserNameValid);

  @override
  Stream<bool> get isPasswordValidOutputs =>
      passwordStreamController.stream.map(isPasswordValid);

  /// userName & password are String but I use dynamic to make methods valid for map method of stream
  bool isUserNameValid(dynamic userName) {
    return userName.isNotEmpty;
  }

  bool isPasswordValid(dynamic password) {
    return password.isNotEmpty;
  }
}

abstract class LoginViewModelInput {
// those inputs (things that user gives them to you) that you will apply at login view (page)
  setUserName(String userName);
  setPassword(String password);

// better naming : clickLoginButton
  login();

// the inputs that is responsible for giving the outputs
// Sink is the pipe that you give an input (stream of inputs) from side
// then, you can listen from another side
  Sink get userNameInputs;
  Sink get passwordInputs;
}

abstract class LoginViewModelOutput {
  // those outputs (things that you gives them to user) that you will appear at login view
  Stream<bool> get isUserNameValidOutputs;
  Stream<bool> get isPasswordValidOutputs;
}
