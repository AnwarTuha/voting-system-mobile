import 'package:voting_system_mobile/utils/constants_util.dart';

class Validator {
  String validatePhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber.trim();

    String regex = kRegExpPhoneNumber;
    RegExp regExp = RegExp(regex);

    if (phoneNumber.isEmpty | !regExp.hasMatch(phoneNumber)) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  String validateName(String name) {
    name = name.trim();
    if (name.isEmpty || name.length < 3) {
      return 'Enter a valid name';
    }

    return null;
  }

  String validateEmail(String email) {
    /* Validate Email from user input
      :param email: String containing email of the user

      :return bool: true if email is valid, false if it's not
    * */

    email = email.trim();

    String regex = kRegExpEmail;
    RegExp regExp = new RegExp(regex);

    if (email.isEmpty || !regExp.hasMatch(email)) {
      return 'Enter a valid email';
    }

    return null;
  }

  String validatePassword(String password) {
    /* Validate Password from user input
      :param password: String containing password of the user
    * */

    /* the following regex validates the following
      - Minimum 1 UpperCase
      - Minimum 1 lowerCase
      - Minimum 1 Numeric Number
      - Minimum 1 Special Character
      - Common Allowed Characters ( ! @ # $ & * ~ )
    * */
    String pattern = kRegExpPassword;

    RegExp regExp = new RegExp(pattern);

    if (!regExp.hasMatch(password)) {
      return 'Please enter a valid password';
    }

    return null;
  }
}
