import 'package:dartz/dartz.dart';
import '../../data/network/requests.dart';
import '../models/models.dart';

import '../../data/network/failure.dart';

abstract class Repository{

 Future<Either<Failure,AuthenticationModel>> login(LoginRequest loginRequest);
 Future<Either<Failure,String>> forgetPassword(String email);

}