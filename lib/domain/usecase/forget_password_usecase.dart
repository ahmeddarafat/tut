import '../../data/network/failure.dart';
import 'package:dartz/dartz.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ForgetPasswordUsecase extends BaseUseCase<String,String>{
  final Repository _repository;

  ForgetPasswordUsecase(this._repository);
  @override
  Future<Either<Failure, String>> execute(String input) async{
    return await _repository.forgetPassword(input);
  }

}