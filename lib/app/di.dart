import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/data/data_source/remote_data_source.dart';
import 'package:tut/data/network/app_api.dart';
import 'package:tut/data/network/dio_factory.dart';
import 'package:tut/data/repository/repository_impl.dart';
import 'package:tut/domain/repository/repository.dart';
import 'package:tut/domain/usecase/login_usecase.dart';
import 'package:tut/presentation/login/viewmodel/login_viewmodel.dart';

import '../data/network/netwrok_info.dart';

// like a map has all instances
final getIt = GetIt.instance;

Future<void> initAppModule() async {
  /// Shared Preferences
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  // lazy means initialize instance when first call
  // singleton means initialize only one instance for whole app
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
    getIt
        .registerFactory<LoginUseCase>(() => LoginUseCase(getIt<Repository>()));

    /// login view model
    getIt.registerFactory<LoginViewModel>(
        () => LoginViewModel(getIt<LoginUseCase>()));
  }
}
