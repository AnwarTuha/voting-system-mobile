import 'dart:convert';

List<Organization> OrganizationFromJson(String str) => List<Organization>.from(json.decode(str).map((mappedJson) => Organization.fromJson(mappedJson)));

class Organization {
  final String organizationName;
  final Address address;
  final String adminId;
  final List<String> phoneNumbers;
  final String email;
  final String organizationId;

  Organization({this.organizationName, this.address, this.adminId, this.phoneNumbers, this.email, this.organizationId});

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      organizationName: json["name"] != null ? json["name"] : "",
      address: Address.fromJson(json["Address"]),
      adminId: json["adminId"] != null ? json["adminId"] : "",
      phoneNumbers: List<String>.from(json["phone"].map((x) => x)),
      email: json["email"] != null ? json["email"] : "",
      organizationId: json["id"] != null ? json["id"] : ""
    );
  }

}

class Address{
  final String city;
  final String country;

  Address({this.city, this.country});

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(
      city: json["city"] != null ? json["city"] : "",
      country: json["country"] != null ? json["city"] : ""
    );
  }

}
