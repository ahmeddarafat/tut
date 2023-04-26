import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tut/domain/models/models.dart';
import 'package:tut/domain/usecase/home_usecase.dart';
import 'package:tut/domain/usecase/store_details_usecase.dart';
import 'package:tut/presentation/base/base_view_model.dart';

import '../../../../../data/network/failure.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

abstract class StoreDetailsInputs {
  Sink<StoreDetailsModel> get storeDetailsInput;
}

abstract class StoreDetailsOutputs {
  Stream<StoreDetailsModel> get storeDetailsOutput;
}

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsInputs, StoreDetailsOutputs {
  final StoreDetailsUseCase _storeDetailsUseCase;
  StoreDetailsViewModel(this._storeDetailsUseCase);

  late final BehaviorSubject<StoreDetailsModel> _storeDetailsStreamController;

  @override
  void start() {
    _storeDetailsStreamController = BehaviorSubject();
    getHomeData();
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  /// Inputs

  @override
  Sink<StoreDetailsModel> get storeDetailsInput =>
      _storeDetailsStreamController.sink;

  /// Outputs

  @override
  Stream<StoreDetailsModel> get storeDetailsOutput =>
      _storeDetailsStreamController.stream;

  /// Helper Methods

  void getHomeData() async {
    stateInput.add(
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState),
    );
    Either<Failure, StoreDetailsModel> either =
        await _storeDetailsUseCase.execute(Void);
    either.fold((failure) {
      // to show failure dialog
      stateInput.add(
        ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message,
        ),
      );
    }, (storeDetailsModel) {
      // To remove loading dialog
      storeDetailsInput.add(storeDetailsModel);
      stateInput.add(ContentState());
    });
  }
}

// TODO: Draft : RxDart
// ------------------ RXdart -------------------
// ---------------------------------------------
// [1] RxDart extends the capabilities of Dart Streams and StreamControllers.
// ---------------------------------------------