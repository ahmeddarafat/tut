// Job:
//    To convert from data (api response)  to domain (models)

import 'package:tut/app/constants.dart';

import '../../domain/models/models.dart';
import '../response/responses.dart';  
import '../../app/extensions.dart';

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
      this?.id ?? Constants.empty,             // try this 
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
