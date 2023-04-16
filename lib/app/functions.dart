bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$")
      .hasMatch(email);
}

bool isPasswordValid(String password) {
  return password.length >= 6;
}

bool isMobileNumberValid(String mobileNumber){
  return mobileNumber.length >=8;
}

bool isNotEmpty(String input) {
  return input.isNotEmpty;
}
