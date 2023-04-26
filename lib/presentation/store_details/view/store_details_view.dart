import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tut/app/di.dart';
import 'package:tut/domain/models/models.dart';
import 'package:tut/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:tut/presentation/resources/constants/app_strings.dart';
import 'package:tut/presentation/resources/router/app_router.dart';
import 'package:tut/presentation/resources/styles/app_colors.dart';
import 'package:tut/presentation/resources/widgets/public_text.dart';
import 'package:tut/presentation/store_details/viewmodel/store_details_viewmodel.dart';

import '../../common/state_renderer/state_renderer_impl.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = getIt<StoreDetailsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const PublicText(
          txt: AppStrings.details,
          color: AppColors.white,
          size: 16,
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.stateOuput,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.getScreenWidget(
              context: context,
              contentWidget: _getBody(),
              retryActionFunction: () => _viewModel.getHomeData(),
            );
          } else {
            return _getBody();
          }
        },
      ),
    );
  }

  Widget _getBody() {
    return StreamBuilder<StoreDetailsModel>(
        stream: _viewModel.storeDetailsOutput,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            StoreDetailsModel storeDetailsObject = snapshot.data!;
            return Padding(
              padding: EdgeInsets.only(
                  left: 15.w, right: 15.w, top: 10.h, bottom: 5.h),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        storeDetailsObject.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 180,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const PublicText(
                      txt: AppStrings.details,
                      color: AppColors.orange,
                      size: 16,
                      fw: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    PublicText(
                      txt: storeDetailsObject.details,
                      color: AppColors.darkGrey,
                      size: 12,
                      max: 10,
                      align: TextAlign.start,
                    ),
                    SizedBox(height: 20.h),
                    const PublicText(
                      txt: AppStrings.services,
                      color: AppColors.orange,
                      size: 16,
                      fw: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    PublicText(
                      txt: storeDetailsObject.details,
                      color: AppColors.darkGrey,
                      size: 12,
                      max: 10,
                      align: TextAlign.start,
                    ),
                    SizedBox(height: 20.h),
                    const PublicText(
                      txt: AppStrings.aboutStore,
                      color: AppColors.orange,
                      size: 16,
                      fw: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    PublicText(
                      txt: storeDetailsObject.details,
                      color: AppColors.darkGrey,
                      size: 12,
                      max: 10,
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("store details data are null"),
            );
          }
        });
  }
}
