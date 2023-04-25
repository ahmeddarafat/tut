import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, HomeModel> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeModel>> execute(_) async {
    return await _repository.getHomeData();
  }
}
