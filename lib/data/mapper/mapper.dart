// Job:
//    To convert from data (api response)  to domain (models)

import 'package:tut/app/constants.dart';

import '../../domain/models/models.dart';
import '../response/responses.dart';
import '../../app/extensions.dart';

/// login & register mapper

extension AuthentecationResponseMapper on AuthentecationResponse? {
  AuthenticationModel toDomain() {
    return AuthenticationModel(
      // I use toDomain method because AuthenticationModel need customerModel not customerResponse
      this?.customer.toDomain(),
      this?.contact.toDomain(),
    );
  }
}

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
      // this? means the instance can be null and when it be null - so I use "??"" - return Constants.empty
      // id may be null, so I use orEmpty method
      this?.id ?? Constants.empty, // try this
      this?.name.orEmpty() ?? Constants.empty, // and try this
      this?.numOfNotificatione ?? Constants.zero,
    );
  }
}

extension ContactResponseMapper on ContactResponse? {
  ContactModel toDomain() {
    return ContactModel(
      this?.phone.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

/// forget password mapper

extension ForgetPasswordResponseMapper on ForgetPasswordResponse {
  String toDomain() => support.orEmpty();
}

/// home mapper

extension HomeResponseMapper on HomeResponse {
  HomeModel toDomain() {
    return HomeModel(
      data?.toDomain(),
    );
  }
}

extension HomeDataResponseMapper on HomeDataResponse {
  HomeDataModel toDomain() {
    return HomeDataModel(
      services?.map((element) => element.toDomain()).toList() ?? [],
      banners?.map((element) => element.toDomain()).toList() ?? [],
      stores?.map((element) => element.toDomain()).toList() ?? [],
    );
  }
}

extension ServiceResponseMapper on ServiceResponse {
  ServiceModel toDomain() {
    return ServiceModel(
      id.orZero(),
      title.orEmpty(),
      image.orEmpty(),
    );
  }
}

extension StoreResponseMapper on StoreResponse {
  StoreModel toDomain() {
    return StoreModel(
      id.orZero(),
      title.orEmpty(),
      image.orEmpty(),
    );
  }
}

extension BannerResponseMapper on BannerResponse {
  BannerModel toDomain() {
    return BannerModel(
      id.orZero(),
      link.orEmpty(),
      title.orEmpty(),
      image.orEmpty(),
    );
  }
}
