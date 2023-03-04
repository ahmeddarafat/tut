import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../viewmodel/onboarding_viewmodel.dart';
import '../../resources/constants/app_assets.dart';
import '../../resources/styles/app_colors.dart';
import '../../resources/constants/app_constants.dart';
import '../../resources/constants/app_strings.dart';
import '../../resources/constants/app_values.dart';
import '../../resources/router/app_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/models/models.dart';

class OnBoardingLayouts extends StatefulWidget {
  const OnBoardingLayouts({super.key});

  @override
  State<OnBoardingLayouts> createState() => _OnBoardingLayoutsState();
}

class _OnBoardingLayoutsState extends State<OnBoardingLayouts> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  void _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        // TODO: make this delay at splash screen
        if (snapshot.hasData) {
          return _getBuildWidget(snapshot.data!);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // helper Methods

  Widget _getBuildWidget(SliderViewObject sliderViewObject) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: AppColors.white),
      ),
      body: SafeArea(
        child: Padding(
          // TODO: add screenUtil package
          padding: const EdgeInsets.all(AppPading.p16),
          child: PageView.builder(
            controller: _pageController,
            itemCount: sliderViewObject.numOfSlides,
            onPageChanged: _viewModel.onPageChanged,
            itemBuilder: (context, index) {
              return OnBoardingPage(
                  onBoardingObject: sliderViewObject.sliderObject);
            },
          ),
        ),
      ),
      bottomSheet: Container(
        height: AppSize.s100,
        color: AppColors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              // TODO: edit splash click
              child: TextButton(
                child: Text(
                  AppStrings.skip,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                },
              ),
            ),
            Expanded(child: _getIndicator(sliderViewObject)),
          ],
        ),
      ),
    );
  }

  Widget _getIndicator(SliderViewObject sliderViewObject) {
    return Container(
      color: AppColors.orange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// left arrow
          GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                _viewModel.goPrevious(),
                duration: const Duration(
                    milliseconds: AppConstants.sliderAnimationTime),
                curve: Curves.easeIn,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(AppPading.p16),
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(AppImages.leftArrowIc),
              ),
            ),
          ),
          // custom dots
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPading.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                ),
            ],
          ),
          // right arrow
          GestureDetector(
            onTap: () {
              _pageController.animateToPage(_viewModel.goNext(),
                  duration: const Duration(
                      milliseconds: AppConstants.sliderAnimationTime),
                  curve: Curves.easeIn);
            },
            child: Padding(
              padding: const EdgeInsets.all(AppPading.p16),
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(AppImages.rightArrowIc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (currentIndex == index) {
      return SvgPicture.asset(
        AppImages.hollowCircleIc,
      );
    }
    return SvgPicture.asset(
      AppImages.solidCircleIc,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject onBoardingObject;
  const OnBoardingPage({super.key, required this.onBoardingObject});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          onBoardingObject.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        Text(
          onBoardingObject.subtitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: AppSize.s40,
        ),
        SvgPicture.asset(
          onBoardingObject.image,
          height: AppSize.s287,
          width: AppSize.s287,
        ),
        const SizedBox(
          height: AppSize.s40,
        )
      ],
    );
  }
}
