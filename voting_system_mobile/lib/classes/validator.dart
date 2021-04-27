class Validator{
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  Validator({this.email, this.password, this.firstName, this.lastName, this.phoneNumber});

  bool validateEmail(){

    /* Validate Email from user input
      :param email: String containing email of the user

      :return bool: true if email is valid, false if it's not
    * */

    String emailTrimmed = email.trim();
    String regex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(regex);

    return email.isNotEmpty && regExp.hasMatch(emailTrimmed);
  }

  bool validatePassword(){
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
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(password);
  }

}