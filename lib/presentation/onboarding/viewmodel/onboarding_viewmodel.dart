import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import '../../../domain/models/models.dart';
import '../../base/base_view_model.dart';

import '../../resources/constants/app_assets.dart';
import '../../resources/constants/app_strings.dart';
import '../../resources/constants/app_values.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void start() {
    _list = _getSliderContent();
    _postDataToView();
  }

  // Inputs

  @override
  int goNext() {
    if (_currentIndex < _list.length - 1) {
      _currentIndex++;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // Outputs

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((event) => event);

  // methods

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderContent() => [
        SliderObject(
          AppStrings.onBoardingTitle1.tr(),
          AppStrings.onBoardingSubtitle1.tr(),
          AppImages.onBoardingLogo1,
          AppSize.s267,
          AppSize.s267,
        ),
        SliderObject(
          AppStrings.onBoardingTitle2.tr(),
          AppStrings.onBoardingSubtitle2.tr(),
          AppImages.onBoardingLogo2,
          AppSize.s326,
          AppSize.s326,
        ),
        SliderObject(
          AppStrings.onBoardingTitle3.tr(),
          AppStrings.onBoardingSubtitle3.tr(),
          AppImages.onBoardingLogo3,
          AppSize.s287,
          AppSize.s287,
        ),
        SliderObject(
          AppStrings.onBoardingTitle4.tr(),
          AppStrings.onBoardingSubtitle4.tr(),
          AppImages.onBoardingLogo4,
          AppSize.s356,
          AppSize.s356,
        ),
      ];

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

//

abstract class OnBoardingViewModelInputs {
  int goNext();
  int goPrevious();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
