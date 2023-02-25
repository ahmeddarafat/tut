import 'package:dio/dio.dart';
import '../../app/constants.dart';
import '../response/responses.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

// add @RestApi({String baseUrl}) for the class you want to create another class that impelement from it
// that overrides all methods and add the functionality for each one
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String? baseUrl}) =
      _AppServiceClient;

  // add @Post(String path) for the method needs to be overrided and post means the type of its method
  @POST(Constants.login)
  Future<AuthentecationResponse> login(
    // @Field([String value]) for the all parameters of methods and it points to values of body of api 
    @Field("email")
    String? email,
    @Field("password")
    String? password,
  );
}




// notes:   "write here the darft of summay and when finishing, move to notion "

// retrofit & retrofit_generator & build_runner 
// [1] these 3 packages work together to Define and Generate your API 
//       - extremely need additional packages : json_serializable  & json_annotation 
// [2] at pubspec.yaml file
//      dependencies:
//        retrofit: '>=3.0.0 <4.0.0'
//      dev_dependencies:
//        retrofit_generator: '>=4.0.0 <5.0.0'
//        build_runner: '>2.3.0 <4.0.0' 
//        json_serializable: '>4.4.0'
//
// [3] Functions
//     1. retrofit is responsible for annotation like : @RestApi() & @Post() &Field()
//     2. retrofit_generator is responsible for generating the autogenerated file
//     3. build_runner is responsible for running the retrofit_generator
//
// [4] Usage
//      1. add @RestApi({String baseUrl}) for the class you want to create another class that impelement from it
//         that overrides all methods and add the functionality for each one
//      2. add @Post(String path) for the method needs to be overrided and post means the type of its method
//      3. @Field([String value]) for the all parameters of methods and it points to values of body of api 
