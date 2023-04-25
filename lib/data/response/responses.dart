// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

// the class you want to generate file that handling json for it
@JsonSerializable()
class BaseResponse {
  // add JsonKey(name: [real name in json]) when you want to make different name of json name in code
  // example: json name => "res_status"
  //          name you want to use when coding  status
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class AuthentecationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contact")
  ContactResponse? contact;

  AuthentecationResponse(
    this.customer,
    this.contact,
  );

  // when you generate the file, now you have auto fromJson & toJson methods
  // called _$NameFromJson  & _$NameToJson
  // you just need to pass them
  factory AuthentecationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthentecationResponseFromJson(json);

  // "this" means the instance that you want to convert it to json
  Map<String, dynamic> toJson() => _$AuthentecationResponseToJson(this);
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotification")
  int? numOfNotificatione;
  CustomerResponse(
    this.id,
    this.name,
    this.numOfNotificatione,
  );

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactResponse(
    this.phone,
    this.email,
    this.link,
  );

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  final String? support;

  ForgetPasswordResponse(this.support);

  
  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);


}


@JsonSerializable()
class HomeResponse extends BaseResponse{
  @JsonKey(name: "data")
  HomeDataResponse? data;
  HomeResponse(this.data);

    factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);



}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "services")
  List<ServiceResponse>? services;
  @JsonKey(name: "banners")
  List<BannerResponse>? banners;
  @JsonKey(name: "stores")
  List<StoreResponse>? stores;
  HomeDataResponse(
    this.services,
    this.banners,
    this.stores,
  );

    factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

}



@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  ServiceResponse(
    this.id,
    this.title,
    this.image,
  );

    factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  StoreResponse(
    this.id,
    this.title,
    this.image,
  );

    factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  BannerResponse(
    this.id,
    this.link,
    this.title,
    this.image,
  );

    factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}

// notes:   "write here the darft of summay and when finishing, move to notion "

// json_annotation & serializable & build_runner
// [1] Function:
//           - These 3 packages works togather to Provides Dart Build System builders for handling JSON.
// [2] Installing:
//      - at pubspec.yaml
//         dependencies:
//            json_annotation: ^4.7.0
//
//          dev_dependencies:
//            build_runner: ^2.0.0
//            json_serializable: ^6.0.0
//
// [3] Usage
//     1. add @JsonSerializable() for each class you want to generate file that handling json for it
//     2. add @JsonKey(name: [real name in json]) when you want to make different name of json name in code
//        example: json name => "res_status"
//        name you want to use when coding => "status"
//
// [4] when you want to generate the file
//     1. write in code ==> part 'fileName.g.dart';     ex: part 'responses.g.dart';
//     2. flutter pub get
//     3. flutter pub run build_runner build --delete-conflicting-outputs
//
// [5] when you generate the file
//     1. now you have autogenerated methods fromJson & toJson methods for each class
//     2. called _$NameFromJson  & _$NameToJson
//     3. you just need to pass them
//
//
// Ex: At responses.g.dart file
//
//   ContactResponse _$ContactResponseFromJson(Map<String, dynamic> json) =>
//       ContactResponse(
//         json['phone'] as String?,
//         json['email'] as String?,
//         json['link'] as String?,
//       );
//
//   Map<String, dynamic> _$ContactResponseToJson(ContactResponse instance) =>
//       <String, dynamic>{
//         'phone': instance.phone,
//         'email': instance.email,
//         'link': instance.link,
//       };
//
// [6] sparate Functions :
//     1. json_annotation is responsible for annotation like : @JsonSerializable() & @JsonKey() & @JsonValue()
//     2. json_serializable is responsible for generating the autogenerated file
//     3. build_runner is responsible for running the json_serializable
