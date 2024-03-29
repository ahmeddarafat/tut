// To show the states of views while changing (loaing, error, data, etc..)
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut/presentation/resources/constants/app_assets.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';
import 'package:tut/presentation/resources/constants/app_values.dart';
import 'package:tut/presentation/resources/styles/app_colors.dart';
import 'package:tut/presentation/resources/widgets/public_button.dart';
import 'package:tut/presentation/resources/widgets/public_text.dart';

enum StateRendererType {
  /// popup
  popUpLoadingState,
  popUpErrorState,
  popUpSuccessState,

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
        return  PopDialog(
          item: RugularItems(
            mainAxisSize: MainAxisSize.min,
            message: AppStrings.loading.tr(),
            json: AppJsons.loading,
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
      case StateRendererType.popUpSuccessState:
        return PopDialog(
          item: SuccessItems(
            message: message,
          ),
        );
      case StateRendererType.fullScreenLoadingState:
        return  Center(
          child:  RugularItems(
            message: AppStrings.loading.tr(),
            json: AppJsons.loading,
          ),
        );
      case StateRendererType.fullScreenErrorState:
        return ErrorItems(
          message: message,
          type: stateRendererType,
          retryActionFunction: retryActionFunction,
        );
      case StateRendererType.fullScreenEmptyState:
        return  RugularItems(
          mainAxisSize: MainAxisSize.min,
          message: AppStrings.loading.tr(),
          json: AppJsons.empty,
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
        child: item,
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: AppSize.s100,
            width: AppSize.s100,
            child: Lottie.asset(AppJsons.error),
          ),
          const SizedBox(height: 10),
          PublicText(
            txt: message,
            color: AppColors.black,
            size: 20,
          ),
          const SizedBox(height: 15),
          PublicButton(
            width: 200,
            onPressed: () {
              if (type == StateRendererType.fullScreenErrorState) {
                retryActionFunction!.call();
              } else {
                Navigator.pop(context);
              }
            },
            title: type == StateRendererType.fullScreenErrorState
                ? AppStrings.retryAgain.tr()
                : AppStrings.ok.tr(),
          )
        ],
      ),
    );
  }
}

class RugularItems extends StatelessWidget {
  final MainAxisSize mainAxisSize;
  final String message;
  final String json;
  const RugularItems({
    super.key,
    this.mainAxisSize = MainAxisSize.max,
    required this.message,
    required this.json,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: mainAxisSize,
        children: [
          SizedBox(
            height: AppSize.s100,
            width: AppSize.s100,
            child: Lottie.asset(json),
          ),
          const SizedBox(height: 10),
          PublicText(
            txt: message,
            color: AppColors.black,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class SuccessItems extends StatelessWidget {
  final String message;
  const SuccessItems({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: AppSize.s100,
            width: AppSize.s100,
            child: Lottie.asset(AppJsons.success),
          ),
          const SizedBox(height: 10),
          const PublicText(
            txt: "Success",
            color: AppColors.black,
            size: 20,
          ),
          const SizedBox(height: 10),
          PublicText(
            txt: message,
            color: AppColors.black,
            size: 18,
            max: 4,
          ),
          const SizedBox(height: 20),
          PublicButton(
            onPressed: () {
              Navigator.pop(context);
            },
            title: "Ok",
          ),
        ],
      ),
    );
  }
}
