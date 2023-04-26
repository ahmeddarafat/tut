import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tut/domain/models/models.dart';
import 'package:tut/domain/usecase/home_usecase.dart';
import 'package:tut/presentation/base/base_view_model.dart';

import '../../../../../data/network/failure.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

abstract class HomeViewModelInputs {
  Sink<List<BannerModel>> get bannersInput;
  Sink<List<ServiceModel>> get servicesInput;
  Sink<List<StoreModel>> get storesInput;
}

abstract class HomeViewModelOutputs {
  Stream<List<BannerModel>> get bannersOutput;
  Stream<List<ServiceModel>> get servicesOutput;
  Stream<List<StoreModel>> get storesOutput;
}

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _homeUseCase;
  HomeViewModel(this._homeUseCase);

  late final BehaviorSubject<List<BannerModel>> bannersStreamController;
  late final BehaviorSubject<List<ServiceModel>> servicesStreamController;
  late final BehaviorSubject<List<StoreModel>> storesStreamController;

  @override
  void start() {
    bannersStreamController = BehaviorSubject();
    servicesStreamController = BehaviorSubject();
    storesStreamController = BehaviorSubject();

    getHomeData();
  }

  @override
  void dispose() {
    bannersStreamController.close();
    servicesStreamController.close();
    storesStreamController.close();
    super.dispose();
  }

  /// Inputs

  @override
  Sink<List<BannerModel>> get bannersInput => bannersStreamController.sink;

  @override
  Sink<List<StoreModel>> get storesInput => storesStreamController.sink;

  @override
  Sink<List<ServiceModel>> get servicesInput => servicesStreamController.sink;

  /// Outputs

  @override
  Stream<List<BannerModel>> get bannersOutput => bannersStreamController.stream;

  @override
  Stream<List<ServiceModel>> get servicesOutput =>
      servicesStreamController.stream;

  @override
  Stream<List<StoreModel>> get storesOutput => storesStreamController.stream;

  /// Helper Methods

  void getHomeData() async {
    stateInput.add(
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState),
    );
    Either<Failure, HomeModel> either = await _homeUseCase.execute(Void);
    either.fold((failure) {
      // to show failure dialog
      stateInput.add(
        ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message,
        ),
      );
    }, (homeModel) {
      // To remove loading dialog
      bannersInput.add(homeModel.data?.banners ?? []);
      servicesInput.add(homeModel.data?.services ?? []);
      storesInput.add(homeModel.data?.stores ?? []);
      stateInput.add(ContentState());
    });
  }
}





/// Darft 

// ------------------ RXdart -------------------
// ---------------------------------------------
// [1] RxDart extends the capabilities of Dart Streams and StreamControllers.
// ---------------------------------------------