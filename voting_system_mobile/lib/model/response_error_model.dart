class ResponseError{
  ResponseError({
    this.name,
    this.message,
    this.code,
  });

  String name;
  String message;
  String code;

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
    name: json["name"],
    message: json["message"],
    code: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": code,
    "name": name,
    "message": message,
  };
}