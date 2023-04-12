/// Job :
///    - class contains the data of request
class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  final String userName;
  final String countryMobileCode;
  final String mobileNumber;
  final String email;
  final String password;
  final String profilePicture;

  RegisterRequest({
   required this.userName,
   required this.countryMobileCode,
   required this.mobileNumber,
   required this.email,
   required this.password,
   required this.profilePicture,
  });
}
