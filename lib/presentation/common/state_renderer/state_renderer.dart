// To show the states of views while changing (loaing, error, data, etc..)
import 'package:flutter/material.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';
import 'package:tut/presentation/resources/constants/app_values.dart';
import 'package:tut/presentation/resources/styles/app_colors.dart';
import 'package:tut/presentation/resources/widgets/public_button.dart';
import 'package:tut/presentation/resources/widgets/public_text.dart';

enum StateRendererType {
  /// popup
  popUpLoadingState,
  popUpErrorState,

  /// full screen
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  /// general
  contentState
}

class StateRenderer extends StatelessWidget {
  final String title;
  final String message;
  final Function retryActionFunction;
  final StateRendererType stateRendererType;
  const StateRenderer({
    super.key,
    this.title = "",
    this.message = AppStrings.loading,
    required this.retryActionFunction,
    required this.stateRendererType,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget();
  }

  Widget _getStateWidget() {
    switch (stateRendererType) {
      case StateRendererType.popUpLoadingState:
        return const PopDialog(
          item: RugularItems(
            mainAxisSize: MainAxisSize.min,
            message: AppStrings.loading,
          ),
        );
      case StateRendererType.popUpErrorState:
        return PopDialog(
          item: ErrorItems(
            message: message,
            type: stateRendererType,
            mainAxisSize: MainAxisSize.min,
          ),
        );
      case StateRendererType.fullScreenLoadingState:
        return const RugularItems(
          message: AppStrings.loading,
        );
      case StateRendererType.fullScreenErrorState:
        return ErrorItems(
          message: message,
          type: stateRendererType,
          retryActionFunction: retryActionFunction,
        );
      case StateRendererType.fullScreenEmptyState:
        return const RugularItems(
          mainAxisSize: MainAxisSize.min,
          message: AppStrings.loading,
        );
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }
}

class PopDialog extends StatelessWidget {
  final Widget item;
  const PopDialog({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)],
          ),
          child: item),
    );
  }
}

class ErrorItems extends StatelessWidget {
  final String message;
  final StateRendererType type;
  final Function? retryActionFunction;
  final MainAxisSize mainAxisSize;
  const ErrorItems({
    super.key,
    required this.message,
    required this.type,
    this.retryActionFunction,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: AppSize.s100,
          width: AppSize.s100,
          child: Container(), // TODO: add image
        ),
        PublicText(
          txt: message,
          color: AppColors.black,
          size: 20,
        ),
        PublicButton(
          onPressed: () {
            if (type == StateRendererType.fullScreenErrorState) {
              retryActionFunction!.call();
            } else {
              Navigator.pop(context);
            }
          },
          title: type == StateRendererType.fullScreenErrorState
              ? AppStrings.tryAgain
              : AppStrings.ok,
        )
      ],
    );
  }
}

class RugularItems extends StatelessWidget {
  final MainAxisSize mainAxisSize;
  final String message;
  const RugularItems({
    super.key,
    this.mainAxisSize = MainAxisSize.max,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: mainAxisSize,
      children: [
        SizedBox(
          height: AppSize.s100,
          width: AppSize.s100,
          child: Container(), // TODO: add animated json
        ),
        PublicText(
          txt: message,
          color: AppColors.black,
          size: 20,
        ),
      ],
    );
  }
}


/// TODO: lec 93 
/// - flutter pub get lottie package
/// - download 3 json files (loading, empty, error) lottiefiles site
/// - instead of image.asset ==> lottie.asset(fileName.json)
