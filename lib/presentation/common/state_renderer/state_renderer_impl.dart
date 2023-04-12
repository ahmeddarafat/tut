import 'package:flutter/material.dart';
import 'package:tut/app/constants.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';

import 'state_renderer.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// loading state (pop, full screen)
class LoadingState extends FlowState {
  final String message;
  final StateRendererType stateRendererType;

  LoadingState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (pop, full screen)
class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  ErrorState({
    required this.stateRendererType,
    this.message = AppStrings.loading,
  });
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content State
class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// empty state
class EmptyState extends FlowState {
  final String message;
  EmptyState(this.message);
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

class SuccessState extends FlowState {
  final String message;
  final StateRendererType stateRendererType;

  SuccessState({
    required this.message,
    required this.stateRendererType,
  });
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// extension to handle the states
extension FlowStateExtension on FlowState {
  Widget getScreenWidget({
    required BuildContext context,
    required Widget contentWidget,
    required Function retryActionFunction,
  }) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popUpLoadingState) {
          showPopUp(context, getMessage(), getStateRendererType());
          return contentWidget;
        } else {
          return StateRenderer(
            message: getMessage(),
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction,
          );
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popUpErrorState) {
          showPopUp(context, getMessage(), getStateRendererType());
          return contentWidget;
        } else {
          return StateRenderer(
            message: getMessage(),
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction,
          );
        }
      case EmptyState:
        return StateRenderer(
          message: getMessage(),
          stateRendererType: getStateRendererType(),
          retryActionFunction: () {},
        );
      case SuccessState:
        dismissDialog(context);
        showPopUp(context, getMessage(), getStateRendererType());
        return contentWidget;
      case ContentState:
        dismissDialog(context);
        return contentWidget;
      default:
        dismissDialog(context);
        return contentWidget;
    }
  }

  // To show popUP "dialog"
  void showPopUp(BuildContext context, String message,
      StateRendererType stateRendererType) {
    // TODO: need more understand
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
          message: message,
          stateRendererType: stateRendererType,
          retryActionFunction: () {}, // TODO: maybe Navigator.pop(context)
        ),
      ),
    );
  }

// to remove dialog if it exist when create new dialog
  void dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      // TODO: need more understand
      //? what is rootNavigator parameter and why dose pop has true parameter
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

// to know if there is a dialog
  bool _isCurrentDialogShowing(BuildContext context) =>
      // TODO: need more understand
      ModalRoute.of(context)?.isCurrent != true;
}
