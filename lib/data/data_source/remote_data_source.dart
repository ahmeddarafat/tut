import '../network/app_api.dart';
import '../network/requests.dart';
import '../response/responses.dart';

abstract class RemoteDataSource{
  Future<AuthentecationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {

  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthentecationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email, loginRequest.password) ;
  }

}