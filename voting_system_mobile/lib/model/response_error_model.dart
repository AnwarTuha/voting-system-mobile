class HttpError {
  HttpError({this.statusCode, this.name, this.message, this.errorCode});

  int statusCode;
  String name;
  String message;
  String errorCode;

  factory HttpError.fromJson(Map<String, dynamic> json) => HttpError(
      statusCode: json["statusCode"],
      name: json["name"],
      message: json["message"],
      errorCode: json["code"]);

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "name": name,
        "message": message,
      };
}
