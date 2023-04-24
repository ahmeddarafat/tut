import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/di.dart';
import '../../../app/functions.dart';
import '../../../domain/usecase/register_usecase.dart';
import '../../common/data_object/freezed_data_classes.dart';

import '../../../data/network/failure.dart';
import '../../../domain/models/models.dart';
import '../../base/base_view_model.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

abstract class RegisterViewModelInputs {
  Sink<String> get userNameInput;
  Sink<String> get mobileNumberInput;
  Sink<String> get emailInput;
  Sink<String> get passwordInput;
  Sink<File> get profilePictureInput;
  Sink<bool> get areAllInputsValidInput;

  void setUserName(String userName);
  void setMobileNumber(String mobileNumber);
  void setCountryMobileCode(String countryMobileCode);
  void setEmail(String email);
  void setPassword(String password);
  void setProfilePicture(File profilePicture);

  void register();
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get isUserNameValidOutput;
  Stream<bool> get ismobileNumberValidOutput;
  Stream<bool> get isEmailValidOutput;
  Stream<bool> get isPasswordValidOutput;
  Stream<File> get profilePictureOutput;
  Stream<bool> get areAllInputsValidOutput;
}

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  final AppPrefs appPrefs= getIt<AppPrefs>();

  late StreamController<String> _userNameStreamController;
  late StreamController<String> _mobileNumberStreamController;
  late StreamController<String> _emailStreamController;
  late StreamController<String> _passwordStreamController;
  late StreamController<File> _profilePictureStreamController;
  late StreamController<bool> _areAllInputsValidStreamController;
  late final StreamController<bool> isUserRegisteredSuccessfullyStreamController;

  RegisterObject _registerObject = RegisterObject("", "+20", "", "", "", "");

  @override
  void start() {
    stateInput.add(ContentState());
    // TODO: broadcast
    // I don't now why these streams need broadcast
    _userNameStreamController = StreamController.broadcast();
    _mobileNumberStreamController = StreamController.broadcast();
    _emailStreamController = StreamController.broadcast();
    _passwordStreamController = StreamController.broadcast();
    _profilePictureStreamController = StreamController.broadcast();
    _areAllInputsValidStreamController = StreamController.broadcast();
    isUserRegisteredSuccessfullyStreamController = StreamController();
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserRegisteredSuccessfullyStreamController.close();
    super.dispose();
  }

  //* Inputs

  @override
  Sink<String> get userNameInput => _userNameStreamController.sink;

  @override
  Sink<String> get mobileNumberInput => _mobileNumberStreamController.sink;

  @override
  Sink<String> get emailInput => _emailStreamController.sink;

  @override
  Sink<String> get passwordInput => _passwordStreamController.sink;

  @override
  Sink<File> get profilePictureInput => _profilePictureStreamController.sink;

  @override
  Sink<bool> get areAllInputsValidInput =>
      _areAllInputsValidStreamController.sink;

  @override
  Future<void> register() async {
    // To show loading dialog
    stateInput.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    Either<Failure, AuthenticationModel> either =
        await _registerUseCase.execute(
      RegisterUseCaseInput(
        userName: _registerObject.userName,
        countryMobileCode: _registerObject.countryMobileCode,
        mobileNumber: _registerObject.mobileNumber,
        email: _registerObject.email,
        password: _registerObject.password,
        profilePicture: _registerObject.profilePicture,
      ),
    );

    either.fold((failure) {
      // to show failure dialog
      stateInput.add(
        ErrorState(
          stateRendererType: StateRendererType.popUpErrorState,
          message: failure.message,
        ),
      );
    }, (authenticationModel) {
      // To remove loading dialog
      stateInput.add(ContentState());
      appPrefs.setUserLoggedIn();
      isUserRegisteredSuccessfullyStreamController.sink.add(true);
    });
  }

  @override
  void setCountryMobileCode(String countryMobileCode) {
    if (countryMobileCode.isNotEmpty) {
      _registerObject =
          _registerObject.copyWith(countryMobileCode: countryMobileCode);
    } else {
      _registerObject = _registerObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }

  @override
  void setEmail(String email) {
    emailInput.add(email);
    if (isEmailValid(email)) {
      _registerObject = _registerObject.copyWith(email: email);
    } else {
      _registerObject = _registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  void setMobileNumber(String mobileNumber) {
    mobileNumberInput.add(mobileNumber);
    if (isMobileNumberValid(mobileNumber)) {
      _registerObject = _registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      _registerObject = _registerObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  void setPassword(String password) {
    passwordInput.add(password);
    if (isPasswordValid(password)) {
      _registerObject = _registerObject.copyWith(password: password);
    } else {
      _registerObject = _registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  void setProfilePicture(File profilePicture) {
    profilePictureInput.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      _registerObject =
          _registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      _registerObject = _registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  void setUserName(String userName) {
    userNameInput.add(userName);
    if (userName.isNotEmpty) {
      _registerObject = _registerObject.copyWith(userName: userName);
    } else {
      _registerObject = _registerObject.copyWith(userName: "");
    }
    _validate();
  }

  //* Outputs

  @override
  Stream<bool> get isUserNameValidOutput =>
      _userNameStreamController.stream.map(isNotEmpty);

  @override
  Stream<bool> get ismobileNumberValidOutput =>
      _mobileNumberStreamController.stream.map(isMobileNumberValid);

  @override
  Stream<bool> get isEmailValidOutput =>
      _emailStreamController.stream.map(isEmailValid);

  @override
  Stream<bool> get isPasswordValidOutput =>
      _passwordStreamController.stream.map(isPasswordValid);

  @override
  Stream<File> get profilePictureOutput =>
      _profilePictureStreamController.stream;

  @override
  Stream<bool> get areAllInputsValidOutput =>
      _areAllInputsValidStreamController.stream.map((_) => _areAllInputValid());

  //* helper methods

  bool _areAllInputValid() {
    return _registerObject.userName.isNotEmpty &&
        _registerObject.email.isNotEmpty &&
        _registerObject.password.isNotEmpty &&
        _registerObject.countryMobileCode.isNotEmpty;
  }

  void _validate() {
    // "true" means that you are setting data, But it is not necessary that it is valid
    areAllInputsValidInput.add(true);
  }
}
