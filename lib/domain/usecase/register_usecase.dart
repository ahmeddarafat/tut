import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, AuthenticationModel> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, AuthenticationModel>> execute(input) async {
    return await _repository.register(RegisterRequest(
      userName: input.userName,
      countryMobileCode: input.countryMobileCode,
      mobileNumber: input.mobileNumber,
      email: input.email,
      password: input.password,
      profilePicture: input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  final String userName;
  final String countryMobileCode;
  final String mobileNumber;
  final String email;
  final String password;
  final String profilePicture;

  RegisterUseCaseInput({
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
