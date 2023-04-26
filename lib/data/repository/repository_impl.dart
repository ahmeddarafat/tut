import 'dart:developer';

import 'package:tut/data/data_source/local_data_source.dart';

import '../data_source/remote_data_source.dart';
import '../mapper/mapper.dart';
import '../network/error_handler.dart';
import '../network/netwrok_info.dart';
import '../../domain/models/models.dart';
import '../network/requests.dart';
import '../network/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/repository.dart';

import '../response/responses.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImpl(
      this._networkInfo, this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      /// there is internet
      try {
        final AuthentecationResponse response =
            await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.success) {
          /// success
          // Right means the right return type
          return Right(response.toDomain());
        } else {
          /// failure -- Business error
          // Left means the Left return type
          return Left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      /// there is not internet
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        ForgetPasswordResponse response =
            await _remoteDataSource.forgetPassword(email);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationModel>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final AuthentecationResponse response =
            await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              ApiInternalStatus.failure,
              response.message ?? ResponseMessage.unknown,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeModel>> getHomeData() async {
    try {
      final HomeResponse response = _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      log("not from cache");
      log(cacheError.toString());
      if (await _networkInfo.isConnected) {
        try {
          final HomeResponse response = await _remoteDataSource.getHomeData();
          if (response.status == ApiInternalStatus.success) {
            _localDataSource.setHomeData(response);
            return Right(response.toDomain());
          } else {
            return Left(
              Failure(
                ApiInternalStatus.failure,
                response.message ?? ResponseMessage.unknown,
              ),
            );
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetailsModel>> getStoreDetails() async {
    try {
      final StoreDetailsResponse response = _localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final StoreDetailsResponse response =
              await _remoteDataSource.getStoreDetails();
          if (response.status == ApiInternalStatus.success) {
            _localDataSource.setStoreDetails(response);
            return Right(response.toDomain());
          } else {
            return Left(
              Failure(
                ApiInternalStatus.failure,
                response.message ?? ResponseMessage.unknown,
              ),
            );
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
}

// Draft

// Either :
//     Function:
//          - it is able to return 2 type
