import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_prefs.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/forget_password_usecase.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import '../presentation/forget_passwrod/viewmodel/forget_password_viewmodel.dart';
import '../presentation/login/viewmodel/login_viewmodel.dart';
import '../presentation/register/viewmodel/register_viewmodel.dart';

import '../data/network/netwrok_info.dart';

// like a map has all instances
final getIt = GetIt.instance;

Future<void> initAppModule() async {
  /// Shared Preferences
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  // lazy means initialize instance when first call
  // singleton means initialize only one instance for whole app and still at memory while app cycle
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  /// app Preferences
  // getIt() means it will pass the suitable instance for AppPrefs()
  getIt.registerLazySingleton<AppPrefs>(
      () => AppPrefs(getIt<SharedPreferences>()));

  /// Network Info
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  /// dio factory
  getIt.registerLazySingleton<DioFactory>(() => DioFactory(getIt<AppPrefs>()));

  /// app service client
  Dio dio = await getIt<DioFactory>().getDio();
  getIt.registerLazySingleton(() => AppServiceClient(dio));

  /// remote data source
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(getIt<AppServiceClient>()));

  /// repository
  getIt.registerLazySingleton<Repository>(
      () => RepositoryImpl(getIt<NetworkInfo>(), getIt<RemoteDataSource>()));
}

void initLoginModule() {
  // To ensure if loginUseCase instance is initialized, don't initialize it again
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    /// login use case
    //  factory
    //       - means that it's just created when I call for it and not stored at memory
    getIt
        .registerFactory<LoginUseCase>(() => LoginUseCase(getIt<Repository>()));

    /// login view model
    getIt.registerFactory<LoginViewModel>(
        () => LoginViewModel(getIt<LoginUseCase>()));
  }
}

void initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUsecase>()) {
    getIt.registerFactory<ForgetPasswordUsecase>(
        () => ForgetPasswordUsecase(getIt<Repository>()));
    getIt.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(getIt<ForgetPasswordUsecase>()));
  }
}

void initRegisterModule() {
  // To ensure if loginUseCase instance is initialized, don't initialize it again
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    getIt
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(getIt<Repository>()));
    /// login view model
    getIt.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(getIt<RegisterUseCase>()));
    getIt.registerFactory<ImagePicker>(
        () => ImagePicker());
  }
}
