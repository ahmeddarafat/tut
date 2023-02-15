abstract class BaseViewModel with BaseViewModelInput, BaseViewModelOutput {}

abstract class BaseViewModelInput {
  void start();
  void dispose();
}

abstract class BaseViewModelOutput {}
