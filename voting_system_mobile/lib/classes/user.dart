class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String userName;

  User({this.firstName, this.lastName, this.email, this.phoneNumber, this.userName});

  // copy user data to store on device
  User copy({
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String userName
  }) => User(
    firstName: firstName ?? this.firstName,
    lastName: firstName ?? this.lastName,
    email: firstName ?? this.email,
    phoneNumber: firstName ?? this.phoneNumber,
    userName: firstName ?? this.userName,
  );

  // prepare to receive data from server
  static User fromJson(Map<String, dynamic> json) => User(
    firstName: json['firstname'],
    lastName: json['lastname'],
    email: json['email'],
    phoneNumber: json['phone'],
    userName: json['username']
  );

  Map<String, dynamic> toJson() => {
    'firstname': firstName,
    'lastname': lastName,
    'email': email,
    'phone': phoneNumber,
    'username': userName
  };


}
