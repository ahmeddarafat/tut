import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StoreDetailsUseCase implements BaseUseCase<dynamic, StoreDetailsModel> {
  final Repository _repository;
  StoreDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetailsModel>> execute(_) async {
    return await _repository.getStoreDetails();
  }
}
