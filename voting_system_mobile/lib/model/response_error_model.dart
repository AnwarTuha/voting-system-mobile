class HttpError {
  HttpError({
    this.statusCode,
    this.name,
    this.message,
  });

  int statusCode;
  String name;
  String message;

  factory HttpError.fromJson(Map<String, dynamic> json) => HttpError(
    statusCode: json["statusCode"],
    name: json["name"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "name": name,
    "message": message,
  };
}