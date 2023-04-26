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

import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _viewModel = getIt<HomeViewModel>();

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
    return StreamBuilder<FlowState>(
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
    );
  }

  Widget _getBody() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h,bottom: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getBanners(),
          SizedBox(height: 20.h),
          const PublicText(
            txt: AppStrings.services,
            color: AppColors.orange,
            size: 16,
            fw: FontWeight.bold,
          ),
          SizedBox(height: 10.h),
          _getServices(),
          const PublicText(
            txt: AppStrings.stores,
            color: AppColors.orange,
            size: 16,
            fw: FontWeight.bold,
          ),
          SizedBox(height: 10.h),
          _getStores(),
        ],
      ),
    );
  }

  Widget _getBanners() {
    return StreamBuilder<List<BannerModel>>(
      stream: _viewModel.bannersOutput,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          List<BannerModel> banners = snapshot.data!;
          return CarouselSlider(
            items: banners.map((banner) {
              return SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(banner.image,fit: BoxFit.cover,),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              height: 150,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _getServices() {
    return StreamBuilder<List<ServiceModel>>(
      stream: _viewModel.servicesOutput,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ServiceModel> service = snapshot.data!;
          return SizedBox(
            height: 140,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: service.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 140,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(service[index].image),
                      ),
                      const SizedBox(height: 10),
                      PublicText(
                        txt: service[index].title,
                        color: AppColors.lightGrey,
                        size: 14,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 15);
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _getStores() {
    return StreamBuilder<List<StoreModel>>(
      stream: _viewModel.storesOutput,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<StoreModel> stores = snapshot.data!;
          return Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 160/120,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true, 
              children: List.generate(
                stores.length,
                (index) {
                  return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.storeDetails);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(stores[index].image,fit: BoxFit.cover,),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
